//
//  MessageQueue.swift
//  Bama-Challange
//
//  Created by Kiarash Vosough on 5/1/23.
//

import Foundation

internal final class MessageQueue {

    internal static let shared = MessageQueue()
    
    internal var messages: [String: Any]

    private init() {
        self.messages = [:]
    }
}
