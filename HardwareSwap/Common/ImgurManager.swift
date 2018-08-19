//
//  ImgurManager.swift
//  HardwareSwap
//
//  Created by Ryan Lauer on 8/18/18.
//  Copyright © 2018 Ryan Lauer. All rights reserved.
//

import Foundation
import UIKit

class ImgurManager {
    var imageData: UIImage = UIImage()
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
