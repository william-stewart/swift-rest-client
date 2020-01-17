//
//  ResponseStructures.swift
//  SwiftRestClient
//
//  Created by William Stewart on 1/16/20.
//  Copyright © 2020 William Stewart. All rights reserved.
//

var emptyString = String(stringLiteral: "")

import Foundation

struct MessagesBoardData: Codable, CustomStringConvertible {
    var results: [MessageInfo]?
    
    var description: String {
        var desc = """
        Messageboard:
        
        """
        if let posts = results {
            for post in posts {
                desc += post.description
            }
        }
        
        return desc
    }
}

struct MessageInfo: Codable, CustomStringConvertible {
    var userID: String?
    var messageTitle: String?
    var message: String?
    
    var description: String {
        return """
        ------------
        userID = \(userID ?? emptyString)
        messageTitle = \(messageTitle ?? emptyString)
        message = \(message ?? emptyString)
        ------------
        """
    }
}
