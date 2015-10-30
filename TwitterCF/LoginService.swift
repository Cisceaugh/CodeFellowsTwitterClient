//
//  LoginService.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/27/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
    // a function that will log in to twitter takes an optional string and acaccount
    class func loginTwitter(completionHandler: (String?, ACAccount?) -> ()) {
        
        // Set up Account Store for accessing/manipulating accounts
        let accountStore = ACAccountStore()
        
        // Returns an account type with a twitter account type identifier of twitter
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        // Goes in and requests access to the twitter 
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: { (granted, error) -> Void in
            if let _ = error {
                completionHandler("ERROR: Request access to accounts returned an error.", nil); return
            }
            
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completionHandler(nil, account); return
                }
                
                // If no account was found
                completionHandler("ERROR: No twitter accounts were found on this device.", nil); return
            }
            
            // If user did not grant access to Account Store for Twitter accounts
            completionHandler("Error: This app requires access to the Twitter Accounts.", nil); return
        })
    }
}
