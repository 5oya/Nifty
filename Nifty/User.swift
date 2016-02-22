//
//  User.swift
//  Nifty
//
//  Created by Soya Takahashi on 2016/02/22.
//  Copyright © 2016年 Ggrape. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    var password: String
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    
    // MEMO: modelはデータだけ見やすくしたいので、モデルに処理を書くのは美しくない気がする
    func signUp(callback: (message: String?) -> Void) {
        let user = NCMBUser()
        user.userName = self.name
        user.password = self.password
        user.signUpInBackgroundWithBlock { (NSError error) in
            callback(message: error?.userInfo["NSLocalizedDescription"] as? String)
        }
    }
    
    func login(callback: (message: String?) -> Void) {
        // ログインをサーバーに要求すると、端末独自のセッショントークンが発行されてセッションとしてログイン情報とともに保持される
        NCMBUser.logInWithUsernameInBackground(self.name, password: self.password) { (NCMBUser user, NSError error) in
            callback(message: error?.userInfo["NSLocalizedDescription"] as? String)
        }
    }
}
