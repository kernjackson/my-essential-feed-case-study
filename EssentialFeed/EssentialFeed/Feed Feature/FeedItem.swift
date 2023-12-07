//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Kern Jackson on 12/5/23.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
