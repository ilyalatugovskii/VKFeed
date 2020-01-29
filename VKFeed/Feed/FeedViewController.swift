//
//  FeedViewController.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/28/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getFeed()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
