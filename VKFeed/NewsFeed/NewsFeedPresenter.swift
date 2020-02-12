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
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    
    switch response {
        
    case .presentNewsFeed(let feedResponse, let revealedPostIds):
        let cells = feedResponse.items.map { cellViewModel(from: $0, profiles: feedResponse.profiles, groups: feedResponse.groups, revealdedPostIds: revealedPostIds) }
        let feedViewModel = FeedViewModel(cells: cells)
        viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
    case .presentUserInfo(let user):
        let userViewModel = UserViewModel(photoUrlString: user?.photo100)
        viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
    }
  
  }
  
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
       
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealdedPostIds.contains { $0 == feedItem.postId }
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizePost: isFullSized)
        
        return FeedViewModel.Cell(postId: feedItem.postId,
                                  iconUrlString: profile.photo,
                                  name: profile.name,
                                  date: dateTitle,
                                  text: feedItem.text,
                                  likes: formattedCounter(feedItem.likes?.count),
                                  comments: formattedCounter(feedItem.coments?.count),
                                  shaares: formattedCounter(feedItem.reposts?.count),
                                  views: formattedCounter(feedItem.views?.count),
                                  photoAttachments: photoAttachments,
                                  sizes: sizes)
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        
        return profileRepresentable!
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        
        return counterString
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.srcBIG, width: firstPhoto.width, height: firstPhoto.height)
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: photo.srcBIG,
                                                         width: photo.width,
                                                         height: photo.height)
        }
    }
}
