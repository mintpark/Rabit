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
    
    func loginButtonClicked() {
        let session: KOSession = KOSession.shared()
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if session.isOpen() {
                print("login success")
            } else {
                print("login fail")
            }
        }
        
    }
}
