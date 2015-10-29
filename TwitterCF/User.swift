//
//  User.swift
//  MyTwitterCF
//
//  Created by Francisco Ragland Jr on 10/28/15.
//  Copyright © 2015 Francisco Ragland. All rights reserved.
//

import Foundation

class User {
    let name: String
    let profileImageURL: String
    
    init (name: String, profileImageURL: String){
        self.name = name
        self.profileImageURL = profileImageURL
    }
}