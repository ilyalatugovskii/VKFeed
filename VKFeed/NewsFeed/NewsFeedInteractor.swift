//
//  NewsFeedInteractor.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/30/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
    private var dataFetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    
    case .getNewsFeed:
        dataFetcher.getFeed { [ weak self ] (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            
            self?.presenter?.presentData(response: .presentNewsFeed(feedResponse: feedResponse))
        }
    }
  }
  
}
