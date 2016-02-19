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
    
    init(text: String) {
        self.text = text
    }
    
    func save() {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject.setObject(text, forKey: "tweet")
        tweetObject.saveInBackgroundWithBlock { (NSError error) in
            if error != nil {
                return
            } else {
                print("保存完了！")
            }
        }
    }
}
