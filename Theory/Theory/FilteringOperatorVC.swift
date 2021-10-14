//
//  FilteringOperatorVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/10/14.
//

import UIKit
import RxSwift
import RxCocoa

class FilteringOperatorVC: UIViewController {
    
    let disposeBag = DisposeBag()
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distinctUntilChangedExample()
    }
    
    func filter() {
        Observable.from(numbers)
            .filter { $0.isMultiple(of: 2) }
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    func ignore() {
        let ignoreElement = PublishSubject<String>()
        ignoreElement
            .ignoreElements()
            .subscribe (onNext: { event in
                print(event)
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                print("완료")
            }
            ).disposed(by: disposeBag)
        
        ignoreElement.onNext("국어")
        ignoreElement.onNext("수학")
        ignoreElement.onNext("영어")
        ignoreElement.onCompleted()
    }
    
    func element() {
        let element = PublishSubject<String>()
        element
            .element(at: 2)
            .subscribe(onNext: { (event) in
                print("내 사랑 \(event)")
            }, onError: { (err) in
                print("\(err.localizedDescription)")
            }, onCompleted: {
                print("완료")
            })
            .disposed(by: disposeBag)
        
        element.onNext("듀나걸")
        element.onNext("듐보걸")
        element.onNext("훈즤킴")
        element.onCompleted()
    }
    
    func skip() {
        let skipExample = PublishSubject<String>()
        skipExample
            .skip(3)
            .subscribe(onNext: { (element) in
                print("앞으로 들어야 할 과목 : \(element)")
            }).disposed(by: disposeBag)
        skipExample.onNext("국어")
        skipExample.onNext("수학")
        skipExample.onNext("영어")
        skipExample.onNext("사회")
        skipExample.onNext("과학")
        skipExample.onNext("미술")
    }
    
    func skipWhile() {
        let skipWhileExample = PublishSubject<Int>()
        skipWhileExample
            .skip(while: {
                $0 % 2 == 0
            })
            .subscribe(onNext: { (element) in
                print("Element \(element)")
            }).disposed(by: disposeBag)
        
        skipWhileExample.onNext(2)
        skipWhileExample.onNext(4)
        skipWhileExample.onNext(5)
        skipWhileExample.onNext(7)
        skipWhileExample.onNext(4)
    }
    
    func skipUntil() {
        let skipUntilExample = PublishSubject<Int>()
        let triggerObservable = PublishSubject<String>()
        
        skipUntilExample
            .skip(until: triggerObservable)
            .subscribe(onNext: { (element) in
                print("Element \(element)")
            }).disposed(by: disposeBag)
        
        skipUntilExample.onNext(1)
        skipUntilExample.onNext(2)
        triggerObservable.onNext("S")
        skipUntilExample.onNext(3)
        skipUntilExample.onNext(4)
    }
    
    func take() {
        let takeExample = PublishSubject<String>()
        takeExample
            .take(3)
            .subscribe(onNext: { (element) in
                print("Element \(element)")
            }).disposed(by: disposeBag)
        
        takeExample.onNext("듀나걸")
        takeExample.onNext("듐보걸")
        takeExample.onNext("훈즤킴")
        takeExample.onNext("안드-현우야미안하다")
    }
    
    func takeWhile() {
        let skipWhileExample = PublishSubject<Int>()
        skipWhileExample
            .take(while: {
                $0 % 2 == 0
            })
            .subscribe(onNext: { (element) in
                print("Element \(element)")
            }).disposed(by: disposeBag)
        
        skipWhileExample.onNext(2)
        skipWhileExample.onNext(4)
        skipWhileExample.onNext(5)
        skipWhileExample.onNext(7)
        skipWhileExample.onNext(4)
    }
    
    func takeUntil() {
        let takeUntilExample = PublishSubject<Int>()
        let triggerObservable = PublishSubject<String>()
        
        takeUntilExample
            .take(until: triggerObservable)
            .subscribe(onNext: { (element) in
                print("Element \(element)")
            }).disposed(by: disposeBag)
        
        takeUntilExample.onNext(1)
        takeUntilExample.onNext(2)
        triggerObservable.onNext("S")
        takeUntilExample.onNext(3)
        takeUntilExample.onNext(4)
    }
    
    func distinctUntilChangedExample() {
        let distinctUntilChangedExample = PublishSubject<Int>()

        distinctUntilChangedExample
          .distinctUntilChanged()
          .subscribe(onNext: { (element) in
              print("Element \(element)")
          }).disposed(by: disposeBag)
        
        distinctUntilChangedExample.onNext(1)
        distinctUntilChangedExample.onNext(2)
        distinctUntilChangedExample.onNext(4)
        distinctUntilChangedExample.onNext(4)
        distinctUntilChangedExample.onNext(4)
        distinctUntilChangedExample.onNext(4)
        distinctUntilChangedExample.onNext(2)
    }
}
