//
//  TimeBasedOperatorVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/11/11.
//

import UIKit
import RxSwift
import RxCocoa

class TimeBasedOperatorVC: UIViewController {
    
    let disposeBag = DisposeBag()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        timer()
//        interval()
//        buffer()
        replay()
    }
    
    
    
    func timer() {
        // timer
//        Observable<Int>
//            .timer(.seconds(1), scheduler: MainScheduler.instance)
//            .subscribe { print($0) }
//            .disposed(by: disposeBag)

        // next(0)
        // completed
        // timer with period

        Observable<Int>
            .timer(.seconds(5), period: .seconds(1), scheduler: MainScheduler.instance)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    
    
    func interval() {
        let observable = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { print($0) }

        // 직접 해제시켜야함
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            observable.dispose()
            
        }
    }
    
    
    func replay() {
        let timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        let replay1 = timer.replay(10)
        let replay2 = timer.replay(7)
        _ = replay1.connect()
        _ = replay2.connect()
        
        replay1.subscribe(onNext: { item in
            print(" MonstarX Minhyuk \(item)")
        }).disposed(by: disposeBag)
        
        replay2.delaySubscription(.seconds(10), scheduler: MainScheduler.instance)
            .subscribe(onNext: { item in
                print(" 캐치미 \(item)")
            }).disposed(by: disposeBag)
    }
    
    
    
    func buffer() {
        let timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"})

//        timer.buffer(timeSpan: .seconds(3), count: 3, scheduler: MainScheduler.instance)
//            .subscribe { event in
//            switch event {
//            case let .next(value):
//                print(value, "안녕")
//            default:
//                print("하세요")
//            }
//
//            }.disposed(by: disposeBag)
        

        timer.window(timeSpan: .seconds(3), count: 2, scheduler: MainScheduler.instance)
            .subscribe { event in
                switch event {
                case let .next(observable):
                    observable.subscribe { e in
                        switch e {
                        case let .next(value):
                            print(value, "안녕")
                        default:
                            print("하세요")
                        }
                    }
                default:
                    print("finished")
                }

            }.disposed(by: disposeBag)
    }
    
}

