//
//  CollectionViewCell.swift
//  HardwareSwap
//
//  Created by Ryan Lauer on 8/3/18.
//  Copyright © 2018 Ryan Lauer. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var postUrl: String = ""
    var userUrl: String = ""
    @IBOutlet weak var timestamp: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var goToPostButton: UIButton!
    
    @IBAction func messageUserClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: userUrl)!)
    }
    
    @IBAction func onGoToPostClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: postUrl)!)
    }
}
