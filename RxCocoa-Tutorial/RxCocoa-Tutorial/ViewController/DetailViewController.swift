//
//  DetailViewController.swift
//  RxCocoa-Tutorial
//
//  Created by Thisisme Hi on 2021/11/24.
//

import UIKit

import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var disposeBag = DisposeBag()
    
    public var nameText: String?
    public var partText: String?
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameText = nameText,
           let partText = partText {
            nameLabel.text = "이름 : " + nameText
            partLabel.text = "파트 : " + partText
        }
        
        /// RxCocoa로 닫기 버튼 구현
        self.closeButton.rx.tap
            .subscribe() { event in
                self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
}
