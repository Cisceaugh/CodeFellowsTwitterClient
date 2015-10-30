//
//  ViewController.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/26/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import UIKit


//This is the home view controller which has my content
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //outlet to my tableView for content
    @IBOutlet weak var tableView: UITableView!
    //an array of my tweets
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the delegate and datasource for my tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let customTweetCellXib = UINib(nibName: "CustomTweetCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomTweetTableViewCell.identifier())
        
        self.setupTableView()
        self.getAccount()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Week 2 Class + Homework.
    
    func getAccount() {
        LoginService.loginTwitter({ (error, account) -> (Void) in
            if let error = error {
                
                print(error)
                return
            }
            
            if let account = account {
                TwitterService.sharedService.account = account
                self.authenticateUser()
            }
        })
    }
    
    func authenticateUser(){
        TwitterService.getAuthUser { (error, user) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let user = user {
                TwitterService.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    func getTweets() {
        TwitterService.tweetsFromHomeTimeline { (error, tweets) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func setUpTableView() {
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == TweetDetailViewController.identifier() {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let tweet = self.tweets[indexPath.row]
                let tweetsDetailViewController = segue.destinationViewController as! TweetDetailViewController
                tweetsDetailViewController.tweet = tweet
            }
        }
    }
    
    // MARK: UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomTweetTableViewCell.identifier(), forIndexPath: indexPath) as! CustomTweetTableViewCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(TweetDetailViewController.indentifier(), sender: nil)
    }
    
}


