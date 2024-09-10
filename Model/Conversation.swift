//
//  Conversation.swift
//  SyncChat
//
//  Created by RANA  on 1/9/24.
//


import Foundation

struct Conversation: Encodable, Hashable, Decodable {
    var participants: [User]
    var lastMessage: Message
    var timestamp: Date
    


    func hash(into hasher: inout Hasher) {
        hasher.combine(participants)
        hasher.combine(lastMessage)
        hasher.combine(timestamp)
    }
    
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        return lhs.participants == rhs.participants &&
               lhs.lastMessage == rhs.lastMessage &&
               lhs.timestamp == rhs.timestamp
    }
}






