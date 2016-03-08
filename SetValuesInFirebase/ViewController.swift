//
//  ViewController.swift
//  SetValuesInFirebase
//
//  Created by James Pacheco on 3/7/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UserController.createUser("jamesrp13") { (user) -> Void in
            if let firstUser = user {
                UserController.createUser("jodie", completion: { (user) -> Void in
                    if let secondUser = user {
                        ConversationController.createConversation("The Best Convo Ever", users: [firstUser, secondUser], completion: { (conversation) -> Void in
                            if let conversation = conversation {
                                ConversationController.createMessage("Hi! This is a test message", sender: firstUser, conversation: conversation, completion: { (message) -> Void in
                                    if let message = message {
                                        print(message)
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

