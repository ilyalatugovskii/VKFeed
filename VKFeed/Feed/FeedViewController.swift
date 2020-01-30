//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/28/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService: Networking = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = ["filters": "post,photo"]
        
        networkService.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Erorr: \(error.localizedDescription)")
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            print(json)
        }
    }


}
