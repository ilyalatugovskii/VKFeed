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
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes
    
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWitdht: CGFloat
    
    init(screenWitdht: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWitdht = screenWitdht
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let backViewWith = screenWitdht - Constants.backInsets.left - Constants.backInsets.right
        
        //MARK: - work with postlabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let witdth = backViewWith - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.heigt(widht: witdth, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizePost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: witdth, height: height)
        }
        
         //MARK: - work with moreTextButton
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        //MARK: - work with attachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: CGFloat.zero, y: attachmentTop), size: CGSize.zero)
        
//        if let attachment = photoAttachment {
//            let aspectRatio = Float(attachment.width) / Float(attachment.height)
//            let height = CGFloat(Float(backViewWith) / aspectRatio)
//
//            attachmentFrame.size = CGSize(width: backViewWith, height: height)
//        }
        
        if let attachment = photoAttachments.first {
            let aspectRatio = Float(attachment.width) / Float(attachment.height)
            let height = CGFloat(Float(backViewWith) / aspectRatio)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: backViewWith, height: height)
            } else if photoAttachments.count > 1 {
               var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superWitdth: backViewWith, photosArray: photos)
                attachmentFrame.size = CGSize(width: backViewWith, height: rowHeight!)
            }
            
        }
        
        //MARK: - work with bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: backViewWith, height: Constants.bottomViewHeight))
        
        //MARK: - work with totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.backInsets.bottom
        
        return Sizes(bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame)
    }
    
}
