//
//  ErrorHandlingVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/12/02.
//

import UIKit

import RxSwift

class ErrorHandlingVC: UIViewController {
    
    enum TestError: Int, Error {
        case notFound = 200
        case noInternet = -1
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catchHandler()
    }
    
    func catchHandler() {
        
        let observable = Observable<Int>
            .create { observer -> Disposable in
                observer.onNext(1)
                observer.onNext(2)
                observer.onNext(3)
                observer.onError(TestError.notFound)
                observer.onError(TestError.noInternet)
                
                return Disposables.create { }
            }
        
        //. catchHandler
        observable
            .catch { err -> Observable<Int> in
                let testError = err as? TestError
                print("catchHandler")
                return .just(testError?.rawValue ?? -1)
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        /// catchAndReturn
        observable
            .catchAndReturn(-1)
            .subscribe(onNext: {
                print($0, "catchAndReturn")
            })
            .disposed(by: disposeBag)
        
        /// retry
//        observable
//            .retry()
//            .subscribe { print($0, "retry") }
//            .disposed(by: disposeBag)
        
        
        /// retry attempthcount
        observable
            .retry(2)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        /// retry when
//        observable
//            .retry { error -> Observable<Int> in
//                return .timer(.seconds(3), scheduler: MainScheduler.instance)
//            }
//            .subscribe{ print($0) }
//            .disposed(by: disposeBag)
        
        print("-----------------------------------")
        /// materialize
        observable
            .materialize()
            .take(2)
            .dematerialize()
            .subscribe { print($0.self, "materialize") }
            .disposed(by: disposeBag)
        
    }
}
