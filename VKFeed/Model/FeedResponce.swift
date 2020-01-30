//
//  FeedResponce.swift
//  VKFeed
//
//  Created by Ilya Latugovskii on 29.01.2020.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation

struct FeedResponceWrapped: Decodable {
    let response: FeedResponce
}

struct FeedResponce: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let coments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
