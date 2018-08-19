//
//  ViewController.swift
//  HardwareSwap
//
//  Created by Ryan Lauer on 8/2/18.
//  Copyright © 2018 Ryan Lauer. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: Properties
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var statusIndicator: UIActivityIndicatorView!
    
    var postList: [Post] = []
    let types: NSTextCheckingResult.CheckingType = .link
    let imgurManager: ImgurManager = ImgurManager()
    
    @IBAction func onSearchClick(_ sender: Any) {
        self.postList = []
        searchTextField.resignFirstResponder()
        self.collectionView.reloadData()
        statusIndicator.startAnimating()
        ApiManager.sharedInstance.getPostsByItem (item: searchTextField.text!, subreddit: "all", onSuccess: { json in
            DispatchQueue.main.async {
                for (_, post): (String, JSON) in json {
                    let _post = Post(price: "", date: "",item:"",author:"",url:"",text: "",subreddit:"",title:"" )
                    _post.Price = post["Price"].string!
                    _post.Date = post["Date"].string!
                    _post.Item = post["Item"].string!
                    _post.Author = post["Author"].string!
                    _post.Url = post["Url"].string!
                    _post.Text = post["Text"].string!
                    _post.Subreddit = post["Subreddit"].string!
                    _post.Title = post["Title"].string!
                    
                    self.postList.append(_post)
                    self.collectionView.reloadData()
                }
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    //MARK: Actions
    
    @IBAction func searchButton(_ sender: UIButton) {
        //testLabel.text = searchTextField.text;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if (postList.count > 0) {
            self.statusIndicator.stopAnimating()
            let imageUrl: URL?
            
            imageUrl = getImageData(text: postList[indexPath.row].Text)
            
            imgurManager.getDataFromUrl(url: imageUrl!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.timestamp.image = UIImage(data: data)
                }
            }
            cell.body.text = postList[indexPath.row].Text
            cell.body.sizeToFit()
            cell.sizeToFit()
            cell.titleName.text = postList[indexPath.row].Item
            cell.postUrl = postList[indexPath.row].Url
            cell.userUrl = "https://www.reddit.com/message/compose/?to=\(postList[indexPath.row].Author.trimmingCharacters(in: .whitespacesAndNewlines))"
            
            //This creates the shadows and other UX
            cell.contentView.layer.cornerRadius = 4.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            return cell
        }
        return cell
    }
    func getImageData(text: String) -> URL? {
        let detector = try? NSDataDetector(types: types.rawValue)
        
        guard let detect = detector else {
            return nil
        }
        let matches = detect.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        for match in matches {
            if match.url?.absoluteString.contains("imgur") != nil {
               return match.url?.absoluteURL
            }
        }
        return nil
    }
}
