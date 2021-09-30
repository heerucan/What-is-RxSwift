//
//  SubjectVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/09/30.
//

import UIKit
import RxSwift
import RxCocoa

enum MyError: Error {
    case error
}

class SubjectVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subject()
    }
    
    func subject() {
        
        print()
        print("PublishSubject --------------------------------------------------")
        
        // 처음 publishSubject를 생성하면 비어있기 때문에 전달해 줄 이벤트가 없는 상태
        let subject = PublishSubject<String>()
        subject.onNext("첫 번째 선물 Event")     // -> 이 이벤트는 출력되지 않음
        
        // 구독된 시점부터 이벤트를 전달하기 때문에 이 시점부터 이벤트 전달 시작
        let observer1 = subject.subscribe { print(" >> 1번째 구독자 : ", $0) }
        observer1.disposed(by: disposeBag)      // -> 이 이벤트는 출력됨
        
        subject.onNext("두 번째 선물 Event")
        
        let observer2 = subject.subscribe { print(" >> 2번째 구독자 : ", $0) }
        observer2.disposed(by: disposeBag)
        
        subject.onNext("세 번째 선물 Event")
        
//        subject.onCompleted()
        subject.onError(MyError.error)
        
        let observer3 = subject.subscribe { print(" >> 3번째 구독자 : ", $0) }
        observer3.disposed(by: disposeBag)
    }
    
}


