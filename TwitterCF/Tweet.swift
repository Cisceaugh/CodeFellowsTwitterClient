//
//  Tweet.swift
//  TwitterCF
//
//  Created by Francisco Ragland Jr on 10/26/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import Foundation

class Tweet {
    
    let userName: String
    let text: String
    var user: User?
    
    init(text: String, id: String, user: User? = nil) {
        self.text = text
        self.id = id
        self.user = user
    }
}