//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Kern Jackson on 12/5/23.
//

import Foundation

public struct FeedItem: Equatable {
	public let id: UUID
	public let description: String?
	public let location: String?
	public let imageURL: URL
	
	public init(id: UUID, description: String?, location: String?, imageURL: URL) {
		self.id = id
		self.description = description
		self.location = location
		self.imageURL = imageURL
	}
}
