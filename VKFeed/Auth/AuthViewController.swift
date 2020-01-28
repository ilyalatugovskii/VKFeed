//
//  AuthViewController.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/27/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authService = AppDelegate.shared().authService
        authService.delegate = self
    }
    
    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
    

}

extension AuthViewController: AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController) {

        present(viewController, animated: true, completion: nil)

    }
    
    func authServiceSignIn() {
        print(#function)
    }
    
    func authServiceDidSignIn() {
         print(#function)
    }
    
    
}
