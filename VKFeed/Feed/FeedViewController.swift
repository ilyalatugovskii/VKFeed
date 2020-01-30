//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/28/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.forEach({ print($0.date) })
        }
    }


}
