//
//  DetailViewController.swift
//  RxCocoa-Tutorial
//
//  Created by Thisisme Hi on 2021/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var nameText: String?
    var partText: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameText = nameText,
           let partText = partText {
            nameLabel.text = nameText
            partLabel.text = partText
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        
    }
    
}
