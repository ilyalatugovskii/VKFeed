//
//  AuthService.swift
//  VKFeed
//
//  Created by Ilya Lagutovsky on 1/27/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import VK_ios_sdk


protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignIn()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    static var shared = AuthService()
    
    private let appId = "7298369"
    private var vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        print("init")
       
    }
    
    func wakeUpSession() {
        let scope = ["offline", "wall", "friends"]
        
        VKSdk.wakeUpSession(scope) { [weak self] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                self?.delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
               // VKSdk.authorize(scope)
                VKSdk.authorize(scope, with: .disableSafariController)
                print("VKAuthorizationState.initialized")
            } else {
                self?.delegate?.authServiceDidSignIn()
                print("auth problem, state \(state) error \(String(describing: error))")
            }
        }
    }
    
    //MARK: - VKSDK Delegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    //MARK: - VKSDK UIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
