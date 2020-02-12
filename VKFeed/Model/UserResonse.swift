//
//  UserResonse.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 2/12/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
