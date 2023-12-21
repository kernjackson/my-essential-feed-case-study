//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Kern Jackson on 12/21/23.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
	internal let id: UUID
	internal let description: String?
	internal let location: String?
	internal let image: URL
}
