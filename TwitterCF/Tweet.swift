//
//  Tweet.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/26/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import UIKit

class Tweet {
    
    let text: String
    let id: String
    var user: User?
    
    let rqText: String?
    let rqUser: User?
    
    var isRetweet: Bool
    
    init(text: String, rqText: String? = nil, id: String, user: User? = nil,
        rqUser: User? = nil, isRetweet: Bool = false) {
        self.text =  text
        self.id = id
        self.user = user
        self.isRetweet = isRetweet
        self.rqUser = rqUser
        self.rqText = rqText

    }
    
}