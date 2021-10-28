//
//  TransformingOperatorVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/10/28.
//

import UIKit
import RxSwift
import RxCocoa

class TransformingOperatorVC: UIViewController {
    
    enum MyError: Error {
        case anError
    }
    
    struct CatchMEiOS {
        var height: BehaviorSubject<Int> // 가장 최신 값을 알고 싶을 때 사용
    }
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flatmaplatest()
    }
    
    func toarray() {
        Observable
            .of("듀나걸", "무릐걸", "듐보걸", "훈즤킴")
            .toArray()
            .subscribe({
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func map() {
        Observable
            .of("CatchME")
            .map {
                
                $0 + " Assemble"
                
            }
            .subscribe({
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func enumerated() {
        Observable
            .of("듀나걸", "무릐걸", "듐보걸", "훈즤킴")
            .enumerated()
            .subscribe({
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func flatmap() {
        let duna = CatchMEiOS(height: BehaviorSubject(value: 163))
        let doombo = CatchMEiOS(height: BehaviorSubject(value: 159))
        
        let doombogirlz = PublishSubject<CatchMEiOS>()
        
        doombogirlz
            .flatMap {
                $0.height
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        print("캐치미 앱잼 당시---------------")
        doombogirlz.onNext(duna)
        doombogirlz.onNext(doombo)
        
        print("캐치미 앱잼 후......................")
        duna.height.onNext(160)
        
        doombogirlz.onNext(doombo)
        duna.height.onNext(159)
        
    }
    
    func flatmaplatest() {
        let duna = CatchMEiOS(height: BehaviorSubject(value: 163))
        let doombo = CatchMEiOS(height: BehaviorSubject(value: 159))
        
        let doombogirlz = PublishSubject<CatchMEiOS>()
        
        doombogirlz
            .flatMapLatest {
                $0.height
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        print("<캐치미 앱잼 당시>")
        doombogirlz.onNext(duna)
        doombogirlz.onNext(doombo)
        
        print()
        print("<캐치미 앱잼 후>")
        duna.height.onNext(160)
        
        doombogirlz.onNext(duna)
        doombogirlz.onNext(doombo)
        duna.height.onNext(159)
        duna.height.onError(MyError.anError) // -> 에러 상황 강제로 만들어 줌
        duna.height.onNext(159)
        
        print()
        print("<듀나걸의 성장판이 닫혔으나 듀나걸은 모르는 상황>")
        doombogirlz.onNext(doombo)
    }
    
    func materialize() {
        let observable = Observable<Int>
            .create { observer -> Disposable in
                observer.onNext(1)
                observer.onNext(2)
                observer.onNext(3)
                observer.onError(NSError(domain: "", code: 100, userInfo: nil))
                observer.onError(NSError(domain: "", code: 200, userInfo: nil))
                return Disposables.create { }
        }

        observable
            .materialize()
            .map { event -> Event<Int> in
                switch event {
                case .error:
                    return .next(999)
                default:
                    return event
                }
            }
            .dematerialize()
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)

        /* Prints
          next(1)
          next(2)
          next(3)
          next(999)
          completed
        */
    }
}



