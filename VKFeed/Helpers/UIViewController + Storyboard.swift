//
//  UIViewController + Storyboard.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/28/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func loadViewController<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        
        if let viewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Is not created view controller: \(name)")
        }
        
    }
}
