//
//  FeedResponce.swift
//  VKFeed
//
//  Created by Ilya Latugovskii on 29.01.2020.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation

struct FeedResponce: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    <#fields#>
}
