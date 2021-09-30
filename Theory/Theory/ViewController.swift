//
//  ViewController.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/09/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private var disposeBag = DisposeBag()
    var disposables: [Disposable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        observable()
    }
    
    func observable() {
        // create
        print("create-----------------")
        Observable<Int>.create { (observer) -> Disposable in
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            
            return Disposables.create()
        }.subscribe(onNext: { event in
            print(event)
        }).disposed(by: disposeBag)

        
        // just
        print("just-----------------")
        let justObservable = Observable.just("루희")
        justObservable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)

        
        // of
        print("of-----------------")
        let ofObservable = Observable.of(["듀나"])
        ofObservable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)

        
        // from
        print("from-----------------")
        let fromObservable: Observable<String> = Observable<String>.from(["듀나", "듐보", "후릐"])
        fromObservable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)

        
        // empty
        print("empty-----------------")
        let emptyObservable = Observable<Void>.empty()
        emptyObservable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)

        
        // never
        print("never-----------------")
        let neverObservable = Observable<Any>.never()
        neverObservable.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)

        
        // range
        print("range-----------------")
        let rangeObservable = Observable<Int>.range(start: 3, count: 6)
        rangeObservable.subscribe { event in
            print(event)
        }.dispose()

        
        // repeatElement
        print("repeatElement-----------------")
        let repeatElementObservable = Observable<Int>.repeatElement(1)
        repeatElementObservable.subscribe { event in
//            print(event)
        }.disposed(by: disposeBag)
        
        
        // interval
//        print("interval-----------------")
//        let intervalObservable = Observable<Int>.interval(RxTimeInterval(2.0), scheduler: MainScheduler.instance)
//        intervalObservable.subscribe { event in
//            print(event)
//        }.disposed(by: disposeBag)

    }

}

