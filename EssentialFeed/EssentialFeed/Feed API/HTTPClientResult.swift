//
//  HTTPClientResult.swift
//  EssentialFeed
//
//  Created by Kern Jackson on 12/7/23.
//

import Foundation

public enum HTTPClientResult {
	case success(Data, HTTPURLResponse)
	case failure(Error)
}

public protocol HTTPClient {
	func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
