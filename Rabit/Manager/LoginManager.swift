//
//  LoginManager.swift
//  Rabit
//
//  Created by Hayoung Park on 01/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import UIKit
import KakaoOpenSDK

final class LoginManager {
    static let shared = LoginManager()
    
    private let KEY_IS_LOGIN = "KEY_IS_LOGIN"
    
    var isLogined: Bool {
        get {
            return UserDefaults.standard.bool(forKey: KEY_IS_LOGIN)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KEY_IS_LOGIN)
        }
    }
    
    func loginButtonClicked() {
        loginKakao()
    }
    
    func logoutButtonClicked() {
        logoutKakao()
    }
    
    func loginKakao() {
        let session: KOSession = KOSession.shared()
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if session.isOpen() {
                self.isLogined = true
                print("login success")
            } else {
                self.isLogined = false
                print("login fail: \(error.debugDescription)")
            }
        }
    }
    
    func logoutKakao() {
        let session: KOSession = KOSession.shared()
        session.logoutAndClose { (success, error) in
            if success {
                self.isLogined = false
                print("logout success")
            } else {
                print("logout fail: \(error.debugDescription)")
            }
        }
    }
}
