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

        authService = AuthService.shared
    }
    
    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
    
}
