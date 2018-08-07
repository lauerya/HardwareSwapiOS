//
//  ViewController.swift
//  HardwareSwap
//
//  Created by Ryan Lauer on 8/2/18.
//  Copyright © 2018 Ryan Lauer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: Properties
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let titleName = ["New 1080", "Used iPad Pro", "Old Keyboard", "Used iPad Pro", "Old Keyboard"]
    
    let timestamp = [UIImage(named: "1080"), UIImage(named: "ipad"), UIImage(named: "modelm"), UIImage(named: "ipad"), UIImage(named: "modelm")]
    
    let body = ["Today I am selling BNIB 1080. Bought it and decided I don't need it. Asking $600", "Up for sale is a lightly used iPad Pro. Asking $450", "Found this in my closet, not sure what it's worth but i'm looking for $50", "Up for sale is a lightly used iPad Pro. Asking $450", "Found this in my closet, not sure what it's worth but i'm looking for $50"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")

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
        return titleName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.timestamp.image = timestamp[indexPath.row]
        cell.titleName.text = titleName[indexPath.row]
        cell.body.text = body[indexPath.row]
        
        //This creates the shadows and modifies the cards a little bit
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
}
