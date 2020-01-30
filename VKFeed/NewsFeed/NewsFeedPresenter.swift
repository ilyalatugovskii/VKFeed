//
//  NewsFeedPresenter.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/30/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    
    switch response {
   
    case .some:
        print(".some presenter")
    case .presentNewsFeed:
        print(".presentNewsFeed presenter")
        viewController?.displayData(viewModel: .displayNewsFeed)
        
    }
  
  }
  
}
