//
//  Tweet.swift
//  Nifty
//
//  Created by Soya Takahashi on 2016/02/15.
//  Copyright © 2016年 Ggrape. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String
    var user: User?
    
    init(text: String) {
        self.text = text
    }
    
    func save(callback: () -> Void) {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject.setObject(text, forKey: "text")
        tweetObject.setObject(NCMBUser.currentUser(), forKey: "user")
        tweetObject.saveInBackgroundWithBlock { (NSError error) in
            if error != nil {
                return
            } else {
                callback()
            }
        }
    }
}
