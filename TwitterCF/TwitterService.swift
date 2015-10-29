//
//  TwitterService.swift
//  MyTwitterCF
//
//  Created by Francisco Ragland Jr on 10/28/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
    
    static let sharedService = TwitterService()
    
    var account: ACAccount?
    var user: User?
    
    class func TweetsFromHomeTimeLine(completion: (String?, [Tweet]?) -> () ) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json") , parameters: nil)
        
        if let account = self.sharedService.account {
            request.account = account
            
            request.performRequestWithHandler { (data, response, error) -> Void in
                if let error = error {
                    print(error.description)
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json could not be completed.", nil); return
                }
                print(response.description)
                
                switch response.statusCode {
                case 200...299:
                    let tweets = TweetJSONParser.TweetFromJSONData(data)
                    completion(nil, tweets)
                case 400...499:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [server side error].", nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [uknown error].", nil)
                    
                }
            }
        }
    }
    
    class func getAuthUser(completion: (String?, User?) ->()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "http://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        if let account = self.sharedService.account {
            request.account = account
            
            request.performRequestWithHandler { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json could not be comepleted", nil);
                    return
                }
                //Test
                switch response.statusCode{
                case 200...299:
                    do {
                        if let userData = try
                        NSJSONSerialization.JSONObjectWithData(data, options:
                        [])as? [String: AnyObject] {
                        if let user = TweetJSONParser.userFromData(userData){
                                    completion(nil, user); return
                        }
                        completion("ERROR: unable to create user object from de-serialized JSON object", nil)
                        }
                    }catch{
                        completion("ERROR: NSJSONSerialization.JSONObjectWithData was unable to de-serialize  JSON object.", nil)
                        }
                case 400...499:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json return status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json return status code \(response.statusCode)",nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json return status code \")
                    }
                }
            }
        }
    }
    
