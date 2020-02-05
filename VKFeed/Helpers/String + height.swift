//
//  String + height.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 2/5/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func heigt(widht: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: widht, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        
        return ceil(size.height)
    }
}
