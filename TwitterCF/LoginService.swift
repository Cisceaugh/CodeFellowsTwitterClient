//
//  LoginService.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/27/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import Foundation
import Accounts

typealias TwitterLoginCompletion = (String?, ACAccount?) -> ()

class LoginService {
    class func loginTwitter(completion: TwitterLoginCompletion) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
            (success, error) -> Void in
            
            if let _ = error {
                completion("Request access to accounts returned an error.", nil); return
            }
            
            if success {
                if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(nil, account)
                }
            }
        }
    }
    
}