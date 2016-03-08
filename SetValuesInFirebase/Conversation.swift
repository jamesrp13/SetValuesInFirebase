//
//  Conversation.swift
//  SetValuesInFirebase
//
//  Created by James Pacheco on 3/7/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class Conversation: FirebaseType {
    
    let kName: String = "name"
    let kUsers: String = "users"
    
    let name: String
    var userIDs: [String] = []
    var users: [User] = []
    var identifier: String?
    var endpoint: String {
        return "conversations"
    }
    
    var jsonValue: [String: AnyObject] {
        return [kName: name, kUsers: userIDs]
    }
    
    init(name: String, users: [User]) {
        self.name = name
        self.users = users
        var identifiers: [String] = []
        for user in users {
            if let identifier = user.identifier {
                identifiers.append(identifier)
            }
        }
        self.userIDs = identifiers
    }
    
    required init?(json: [String: AnyObject], identifier: String) {
        guard let name = json[kName] as? String else {
            self.name = ""
            return nil
        }
        self.name = name
        self.identifier = identifier
        if let usersDictionary = json[kUsers] as? [String: AnyObject] {
            userIDs = Array(usersDictionary.keys)
        }
    }
}