//
//  TweetJSONParser.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/26/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//  test comment

import Foundation

class TweetJSONParser {
    
    class func TweetFromJSONData(json: NSData) -> [Tweet]? {
        
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                
                print(rootObject)
                
                var tweets = [Tweet]()
                
                for tweetObject in rootObject {
                    
                    if let text = tweetObject["text"] as? String, id = tweetObject["id_str"] as? String, user = tweetObject["user"] as? [String: AnyObject] {
                        
                        let tweet = Tweet(text: text, id: id)
                        
                        if let name = user["name"] as? String, profileImageURL = user["profile_image_url"] as? String {
                            tweet.user = User(name: name, profileImageURL: profileImageURL)
                        }
                        
                        tweets.append(tweet)
                    }
                }
                return tweets
            }
        } catch _ {
        
            return nil
        }
        
        return nil
    }
    
    class func userFromData(user: [String: AnyObject]) -> User? {
        if let name = user["name"] as? String, profileImageURL = user["profile_image_url"] as? String {
            return User(name: name, profileImageURL: profileImageURL)
        }
        
        return nil
    }
}