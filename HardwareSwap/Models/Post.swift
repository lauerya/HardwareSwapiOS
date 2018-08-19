//
//  Post.swift
//  HardwareSwap
//
//  Created by Ryan Lauer on 8/18/18.
//  Copyright © 2018 Ryan Lauer. All rights reserved.
//

import Foundation

class Post {
    var Price: String
    var Date: String
    var Item: String
    var Author: String
    var Url: String
    var Text: String
    var Subreddit: String
    var Title: String
    
    init(price: String, date: String, item: String, author: String, url: String, text: String, subreddit: String, title: String) {
        self.Price = price
        self.Date = date
        self.Item = item
        self.Author = author
        self.Url = url
        self.Text = text
        self.Subreddit = subreddit
        self.Title = title
    }
}
