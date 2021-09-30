//
//  RelayVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/09/30.
//

import UIKit
import RxSwift
import RxCocoa

class RelayVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        publishRelay()
        behaviorRelay()
    }

    func publishRelay() {
        
        let relay = PublishRelay<String>() // 빈 생성자로 생성
        
        relay.accept("내가 보이니?")
        
        relay.subscribe{
            print("1 : \($0)")
        }.disposed(by: disposeBag)
        
        relay.accept("1번째 Event")
        relay.accept("2번째 Event")
    }
    
    func behaviorRelay() {
        
        let relay = BehaviorRelay<String>(value: "초기값")

        relay.subscribe{
            print("1 : \($0)")
        }.disposed(by: disposeBag)
        
        relay.accept("1번째 Event")
        relay.accept("2번째 Event")
    }
}
