//
//  EssentialFeedTests.swift
//  EssentialFeedTests
//
//  Created by Kern Jackson on 12/5/23.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        let _ = RemoteFeedLoader()
                
        XCTAssertNil(client.requestedURL)
    }
}
