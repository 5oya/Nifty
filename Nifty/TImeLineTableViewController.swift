//
//  TImeLineTableViewController.swift
//  Nifty
//
//  Created by Soya Takahashi on 2016/02/15.
//  Copyright © 2016年 Ggrape. All rights reserved.
//

import UIKit

class TImeLineTableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    // 初めて生成
    let tweetManager = TweetManaer.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tweetManager.fetchAllTweets { () in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .Plain, target: self, action: "post")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logout")
        tweetManager.fetchAllTweets { () in
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NCMBUser.currentUser() == nil {
            performSegueWithIdentifier("modalLoginViewController", sender: self)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweetManager.tweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        cell.nameLabel.text = tweet.user?.name
        cell.tweetLabel.text = tweet.text
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }

    // MARK: - Navigation

    func post() {
        let tweet = Tweet(text: textField.text!)
        tweet.save { () -> Void in
            self.tweetManager.fetchAllTweets { () in
                self.tableView.reloadData()
            }
        }
    }
    
    // ログアウトすることで端末のセッショントークンが無効になります。
    // セッショントークンはログアウトしなくてもデフォルトで24時間たつと無効になります。
    func logout() {
        NCMBUser.logOut()
        performSegueWithIdentifier("modalLoginViewController", sender: self)
    }
}
