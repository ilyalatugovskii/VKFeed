//
//  NewsFeedCellLayoutCalculator.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 2/5/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
}

struct Constants {
    static let backInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 41
    static let postLabelInsets = UIEdgeInsets(top: 5 + Constants.topViewHeight + 3, left: 5, bottom: 5, right: 5)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWitdht: CGFloat
    
    init(screenWitdht: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWitdht = screenWitdht
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let backViewWith = screenWitdht - Constants.backInsets.left - Constants.backInsets.right
        
        //MARK: - work with postlabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let witdth = backViewWith - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.heigt(widht: witdth, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: witdth, height: height)
        }
        
        //MARK: - work with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: CGFloat.zero, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment {
            let aspectRatio = Float(attachment.width) / Float(attachment.height)
            let height = CGFloat(Float(backViewWith) / aspectRatio)
            
            attachmentFrame.size = CGSize(width: backViewWith, height: height)
        }
        
        //MARK: - work with bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: backViewWith, height: Constants.bottomViewHeight))
        
        let totalHeight = bottomViewFrame.maxY + Constants.backInsets.bottom
        
        return Sizes(bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame)
    }
    
}
