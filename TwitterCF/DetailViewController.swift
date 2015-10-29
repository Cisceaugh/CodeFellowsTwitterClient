//
//  DetailViewController.swift
//  MyTwitterCF
//
//  Created by Francisco Ragland Jr on 10/28/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            print(tweet.text)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
