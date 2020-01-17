//
//  ViewController.swift
//  SwiftRestClient
//
//  Created by William Stewart on 1/16/20.
//  Copyright © 2020 William Stewart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let apiBaseUrl = "https://williamstewart.dev/ios-api"
    let restClient = RestClient()
    
    //Test variables
    let testUser1 = "ylinder"
    let testBoardName = "alternate"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllMessages()
        getMessageByUser(user: testUser1)
        getMessageByBoard(boardName: testBoardName)
    }

    func getAllMessages() {
        guard let url = URL(string: apiBaseUrl + "/allmessages") else { return }
        
        restClient.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                guard let testData = try? decoder.decode(MessagesBoardData.self, from: data) else { return }
                print("returned from all messages route\n" + testData.description)
            }
            
            print("\n\nAll messages headers:\n")
            if let response = results.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
            }
        }
    }
    
    func getMessageByUser(user: String) {
        let param = "/" + user
        guard let url = URL(string: apiBaseUrl + "/msg" + param) else { return }
        
        restClient.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                guard let testData = try? decoder.decode(MessagesBoardData.self, from: data) else { return }
                print("returned from message by user route\n" + testData.description)
            }
            
            print("\n\nUser route headers:\n")
            if let response = results.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
            }
        }
    }
    
    func getMessageByBoard(boardName: String) {
        let param = "/" + boardName
        guard let url = URL(string: apiBaseUrl + "/board" + param) else { return }
        
        restClient.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                guard let testData = try? decoder.decode(MessagesBoardData.self, from: data) else { return }
                print("returned from message by board route\n" + testData.description)
            }
            
            print("\n\nBoard route headers:\n")
            if let response = results.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
            }
        }
    }
    
    func addMessage() {
        guard let url = URL(string: apiBaseUrl + "/addmsg") else { return }
        
        restClient.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        restClient.httpBodyParameters.add(value: "xperez", forKey: "userID")
        restClient.httpBodyParameters.add(value: "Main", forKey: "boardName")
        restClient.httpBodyParameters.add(value: "message from app 1", forKey: "messageTitle")
        restClient.httpBodyParameters.add(value: "Description of message from app 1", forKey: "message")
        
        restClient.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let testData = try? decoder.decode(MessageInfo.self, from: data) else { return }
                print(testData.description)
            }
        }
    }

}

