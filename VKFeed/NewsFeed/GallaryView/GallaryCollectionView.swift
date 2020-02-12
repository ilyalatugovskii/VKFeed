//
//  GallaryCollectionView.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 2/11/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class GallaryCollectionView: UICollectionView {

    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        delegate = self
        dataSource = self
        register(GallaryCollectionViewCell.self, forCellWithReuseIdentifier: GallaryCollectionViewCell.reuseId)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
}

extension GallaryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: GallaryCollectionViewCell.reuseId, for: indexPath) as! GallaryCollectionViewCell
        
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
}

extension GallaryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
    
    
}
