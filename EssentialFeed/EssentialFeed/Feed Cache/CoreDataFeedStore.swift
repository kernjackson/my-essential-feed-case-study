//
//  CoreDataFeedStore.swift
//  EssentialFeedTests
//
//  Created by Kern Jackson on 12/29/23.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
	public init() {}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		completion(.empty)
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {

	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {

	}

}
