//
//  ApiManager.swift
//  HardwareSwap
//
//  Created by Ryan Lauer on 8/18/18.
//  Copyright © 2018 Ryan Lauer. All rights reserved.
//

import UIKit

class ApiManager: NSObject {
    let baseUrl = "https://6cg58ugkfb.execute-api.us-east-2.amazonaws.com/production"
    static let sharedInstance = ApiManager()
    
    func getPostsEndpoint(item: String, subreddit: String?) -> String {
        return "?item=\(item)&subreddit\(subreddit ?? "all")"
    }
    
    func getPostsByItem(item: String, subreddit: String?, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        let urlItem = item.replacingOccurrences(of: " ", with: "+")
        let url: String = baseUrl + getPostsEndpoint(item: urlItem, subreddit: subreddit)
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else {
                let result = try! JSON(data: data!)
                if (result.rawString()?.contains("A connection was successfully established with the server, but then an error occurred during the pre-login handshake"))! {
                    onFailure(error!)
                }
                onSuccess(result)
            }
        })
        task.resume()
    }
}
