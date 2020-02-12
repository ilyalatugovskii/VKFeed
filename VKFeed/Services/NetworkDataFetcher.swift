//
//  NetworkDataFetcher.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/30/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponce?) -> ())
    func getUser(response: @escaping (UserResponse?) -> ())
}
struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    private let authService = AuthService.shared
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponce?) -> ()) {
        let params = ["filters": "post,photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponceWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> ()) {
        guard let userId = authService.userId else { return }
        let params = ["fields": "photo_100", "user_ids": userId]
        
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    
}
