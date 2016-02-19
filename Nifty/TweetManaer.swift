//
//  TweetManaer.swift
//  Nifty
//
//  Created by Soya Takahashi on 2016/02/15.
//  Copyright © 2016年 Ggrape. All rights reserved.
//

import UIKit

class TweetManaer: NSObject {
    
    // シングルトンの変数
    static let sharedInstance = TweetManaer()
    // シングルトンが持つプロパティ
    var tweets = [Tweet]()
    
    func fetchAllTweets(callback: () -> Void) {
        let query = NCMBQuery(className: "Tweet")
        query.orderByDescending("createDate")
        query.findObjectsInBackgroundWithBlock { (NSArray objects, NSError error) in
            if error != nil {
                print("Error: \(error)")
                return
            } else {
                print("登録件数: \(objects.count)")
                self.tweets = []
                for object in objects {
                    let text = object.objectForKey("text")!
                    let tweet = Tweet(text: text as! String)
                    self.tweets.append(tweet)
                    callback()
                }
            }
        }
    }
}
