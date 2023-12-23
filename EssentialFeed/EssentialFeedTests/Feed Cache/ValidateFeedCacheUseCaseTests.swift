//
//  ValidateFeedCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Kern Jackson on 12/22/23.
//

import XCTest
import EssentialFeed

class ValidateFeedCacheUseCaseTests: XCTestCase {
	
	func test_init_doesNotMessageStoreUponCreation() {
		let (_, store) = makeSUT()
		
		XCTAssertEqual(store.receivedMessages, [])
	}
	
	func test_validateCache_DeletesCacheEffectsOnRetrievalError() {
		let (sut, store) = makeSUT()
		
		sut.validateCache()
		store.completeRetrieval(with: anyNSError())
		
		XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCacheFeed])
	}
	
	func test_validateCache_doesNotDeleteCacheOnEmptyCache() {
		let (sut, store) = makeSUT()
		
		sut.validateCache()
		store.completeRetrievalWithEmptyCache()
		
		XCTAssertEqual(store.receivedMessages, [.retrieve])
	}
	
	func test_validateCache_doesNotDeleteCacheOnLessThanSevenDaysOldCache() {
		let feed = uniqueImageFeed()
		let fixedCurrentData = Date()
		let lessThanSevenDaysOldTimestamp = fixedCurrentData.adding(days: -7).adding(seconds: 1)
		let (sut, store) = makeSUT(currentDate: { fixedCurrentData } )
		
		sut.validateCache()
		store.completeRetrieval(with: feed.local, timestamp: lessThanSevenDaysOldTimestamp)
		
		XCTAssertEqual(store.receivedMessages, [.retrieve])
	}
	
	func test_validateCache_deletesOnSevenDaysOldCache() {
		let feed = uniqueImageFeed()
		let fixedCurrentData = Date()
		let lessThanSevenDaysOldTimestamp = fixedCurrentData.adding(days: -7)
		let (sut, store) = makeSUT(currentDate: { fixedCurrentData } )
		
		sut.validateCache()
		store.completeRetrieval(with: feed.local, timestamp: lessThanSevenDaysOldTimestamp)
		
		XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCacheFeed])
	}
	
	func test_load_deletesOnMoreThanSevenDaysOldCache() {
		let feed = uniqueImageFeed()
		let fixedCurrentData = Date()
		let moreThanSevenDaysOldTimestamp = fixedCurrentData.adding(days: -7).adding(seconds: -1)
		let (sut, store) = makeSUT(currentDate: { fixedCurrentData } )
		
		sut.validateCache()
		store.completeRetrieval(with: feed.local, timestamp: moreThanSevenDaysOldTimestamp)
		
		XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCacheFeed])
	}
	
	func test_validateCache_doesNotDeleteInvalidCacheAfterSUTInstanceHasBeenDeallocated() {
		let store = FeedStoreSpy()
		var sut: LocalFeedLoader? = LocalFeedLoader(store: store, currentDate: Date.init)
		
		sut?.validateCache()
		
		sut = nil
		store.completeRetrieval(with: anyNSError())
		
		XCTAssertEqual(store.receivedMessages, [.retrieve])
	}
	
	// MARK: - Helpers
	
	private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
		let store = FeedStoreSpy()
		let sut = LocalFeedLoader(store: store, currentDate: currentDate)
		trackForMemoryLeaks(store, file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		return (sut, store)
	}
	
}