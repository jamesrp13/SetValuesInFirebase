//
//  ConversationController.swift
//  SetValuesInFirebase
//
//  Created by James Pacheco on 3/7/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import Foundation

class ConversationController {
    
    static func fetchConversationForIdentifier(identifier: String, completion: (conversation: Conversation?) -> Void) {
        FirebaseController.base.childByAppendingPath("conversations/\(identifier)").observeSingleEventOfType(.Value, withBlock: { (data) -> Void in
            if let conversationDictionary = data.value as? [String: AnyObject] {
                if let conversation = Conversation(json: conversationDictionary, identifier: identifier) {
                    completion(conversation: conversation)
                } else {
                    completion(conversation: nil)
                }
            } else {
                completion(conversation: nil)
            }
        })
    }
    
    static func createConversation(name: String, users: [User], completion: (conversation: Conversation?) -> Void) {
        var conversation = Conversation(name: name, users: users)
        conversation.save()
        if let conversationID = conversation.identifier {
            for var user in users {
                user.conversationIDs.append(conversationID)
                user.save()
            }
        }
        completion(conversation: conversation)
    }
    
    static func createMessage(text: String, sender: User, conversation: Conversation, completion: (message: Message?) -> Void) {
        guard let senderID = sender.identifier,
            conversationID = conversation.identifier else {completion(message: nil); return}
        var message = Message(text: text, senderID: senderID, conversationID: conversationID)
        message.save()
        completion(message: message)
    }
    
}