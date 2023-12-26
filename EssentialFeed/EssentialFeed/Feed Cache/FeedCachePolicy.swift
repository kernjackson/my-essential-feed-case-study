//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Kern Jackson on 12/26/23.
//

import Foundation

internal final class FeedCachePolicy {
	private init() {}
	
	private static let calendar = Calendar(identifier: .gregorian)

	private static var maxCacheAgeInDays: Int {
		return 7
	}
	
	internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
		let calendar = Calendar(identifier: .gregorian)
		guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
			return false
		}
		return date < maxCacheAge
	}
}
