//
//  RootViewController.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/29/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var currentVC: UIViewController
    
    init(current viewController: UIViewController) {
        currentVC = viewController
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(currentVC)
        currentVC.view.frame = view.bounds
        view.addSubview(currentVC.view)
        currentVC.didMove(toParent: self)
    }
    
//    func showLoginScreen(loginViewController: UIViewController) {
//        
//        let newVC = UINavigationController(rootViewController: loginViewController)
//        
//        addChild(newVC)
//        newVC.view.frame = view.bounds
//        view.addSubview(newVC.view)
//        newVC.didMove(toParent: self)
//        
//        currentVC.willMove(toParent: nil)
//        currentVC.view.removeFromSuperview()
//        currentVC.removeFromParent()
//        
//        currentVC = newVC
//    }
    
    func switchLogout(to loginViewController: UIViewController) {
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    }
    
    func switchMainScreen(to feedViewController: UIViewController) {
        
        
        
        let mainScreen = UINavigationController(rootViewController: feedViewController)
        //let mainScreen = MainNavigationController(rootViewController: mainViewController)
        
        animateFadeTransition(to: mainScreen)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        currentVC.willMove(toParent: nil)
        addChild(new)
        transition(from: currentVC, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            
        }) { completed in
            self.currentVC.removeFromParent()
            new.didMove(toParent: self)
            self.currentVC = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        currentVC.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: currentVC, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { completed in
            self.currentVC.removeFromParent()
            new.didMove(toParent: self)
            self.currentVC = new
            completion?()
        }
    }
    
}
