//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Kern Jackson on 12/5/23.
//

import Foundation

public enum LoadFeedResult {
	case success([FeedImage])
	case failure(Error)
}

public protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}
