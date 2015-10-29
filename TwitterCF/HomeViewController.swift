//
//  ViewController.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/26/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshBarButton: UIBarButtonItem!
    var spinner: UIActivityIndicatorView
    
    var tweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem = self.refreshBarButton
        }
    }
    
    class func identifier() -> String {
        return "HomeViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.getTweets()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == DetailViewController.identifier() {
//            let detailViewController = segue.destinationViewController as! DetailViewController
//            let indexPath = self.tableView.indexPathForSelectedRow {
//                let tweet = self.tweets[self.tableView.indexPathForSelectedRow.row]
//                DetailViewController.tweet = tweet
// 
//            }
//            
//        }
//    }
    
    func getAccount() {
        LoginService.loginTwitter({ (error, account) -> () in
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
    
    func authenticateUser() {
        TwitterService.getAuthUser { (error, user) -> () in
            if let error = error{
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
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.spinner)
        }
        
        TwitterService.tweetsFromTimeLine { (error, tweets) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                })
            }
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 2
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.refreshBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem, target: self, action: "getTweets")
        self.navigationItem.rightBarButtonItem = self.refreshBarButton
        
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.spinner.hidesWhenStopped = true

    }
    
    // MARK: UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)
        let tweet = tweets[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        if let user = tweet.user {
            cell.detailTextLabel?.text = "Posted by: \(user.name)"
        } else {
            cell.detailTextLabel?.text = "Posted by: Sponsor."
        }
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        return cell
        
        }
}
