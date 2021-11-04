//
//  CombiningOperatorVC.swift
//  Theory
//
//  Created by Thisisme Hi on 2021/11/04.
//

import UIKit

import RxSwift

class CombiningOperatorVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    public func example(of description: String,
                        action: () -> Void) {
        print("\n— Example of:", description, "—")
        action()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        example(of : "startWith") {
        //            let numbers = Observable.of("duna", "doombo", "huree")
        //
        //            let observable = numbers.startWith("집합!!!!")
        //
        //            observable.subscribe(onNext : { value in
        //                print(value)
        //            })
        //        }
        //
        //        example(of: "Observable.concat") {
        //            let android = Observable.of("nunu", "rinajo", "heimabubsa")
        //            let ios = Observable.of("duna", "doombo", "huree")
        //
        //            let observable = android.concat(ios)
        //
        //            observable.subscribe(onNext : {value in
        //                print(value)
        //            })
        //        }
        
        //        example(of: "concatMap") {
        //            let sequences = [
        //                "안드로이드" : Observable.of("누누", "조리나", "흑마"),
        //                "아요" : Observable.of("듀나", "듐보", "후릐")
        //            ]
        //
        //            let observable = Observable.of("안드로이드","아요").concatMap { country in
        //                sequences[country] ?? .empty()
        //
        //            }
        //
        //            _ = observable.subscribe(onNext : { string in
        //                print(string)
        //
        //            })
        //
        //        }
        //
        //        example(of: "flatMap") {
        //            let sequences = [
        //                "안드로이드" : Observable.of("누누", "조리나", "흑마"),
        //                "아요" : Observable.of("듀나", "듐보", "후릐")
        //            ]
        //
        //            let observable = Observable.of("안드로이드","아요").flatMap { country in
        //                sequences[country] ?? .empty()
        //
        //            }
        //
        //            _ = observable.subscribe(onNext : { string in
        //                print(string)
        //
        //            })
        //
        //        }
        //
        //        example(of : "reduce"){
        //            let source = Observable.of(1,3,5,7,9)
        //
        //            let observable = source.reduce(0, accumulator: {summary, newValue in
        //                return summary + newValue
        //
        //            })
        //
        //            observable.subscribe { value in
        //                print(value)
        //            }
        //
        //        }
        
        
        
                example(of : "scan"){
        
                    let source = Observable.of("이현우", "조승희", "김서진", "신윤아", "양수빈", "김루희", "최영재", "권세훈")
        
                    let observable = source.scan("개발자 치미들 최종 팀빌딩 :") { (preValue, newValue) in
                        return preValue + " " + newValue
                    }
                    
                    observable.subscribe(onNext : {value in
                        print(value)
                        
                    })
                }
        
        
        //        example(of: "combineLatest"){
        //            let girl = PublishSubject<String>()
        //            let boy = PublishSubject<String>()
        //
        //            let observable = Observable.combineLatest(girl, boy, resultSelector:  { lastGirl, lastBoy in
        //
        //                "\(lastGirl) ❤️ \(lastBoy)"
        //            })
        //
        //            let disposable = observable.subscribe(onNext : {value in
        //
        //                print(value)
        //
        //            })
        //
        //            print("> Sending a value to girl")
        //            girl.onNext("천서진")
        //
        //            print("> Sending a value to boy")
        //            boy.onNext("하박사")
        //
        //            print("> Sending another value to boy")
        //            boy.onNext("주단태")
        //
        //            print("> Sending another value to girl")
        //            girl.onNext("심수련")
        //
        //            disposable.dispose()
        //        }
        
        
        //        example(of: "zip"){
        //
        //            let left = Observable.of("후릐", "흑마", "해리", "훈즤", "킴씨")
        //            let right = Observable.of("캐치미 아요 개발자", "캐치미 안드 개발자", "캐치미 기획자", "캐치미 디자이너")
        //
        //            let observable = Observable.zip(left, right) { name, job in
        //                return "\(name)의 직업은 \(job)이다."
        //            }
        //
        //            observable.subscribe(onNext : {value in
        //                print(value)
        //            })
        //        }
        
        
        //        example(of: "withLatestFrom"){
        //
        //            let button = PublishSubject<Void>()
        //            let textField = PublishSubject<String>()
        //
        //            let observable = button.withLatestFrom(textField)
        //            _ = observable.subscribe(onNext : {value in
        //                print(value)
        //            })
        //
        //            textField.onNext("이ㄹ")
        //            textField.onNext("이르")
        //            textField.onNext("이름")
        //            button.onNext(())
        //            button.onNext(())
        //        }
        //
        //        example(of: "sample"){
        //
        //            let button = PublishSubject<Void>()
        //            let textField = PublishSubject<String>()
        //
        //            let observable = textField.sample(button)
        //            _ = observable.subscribe(onNext : {value in
        //                print(value)
        //            })
        //
        //            textField.onNext("이ㄹ")
        //            textField.onNext("이르")
        //            textField.onNext("이름")
        //            button.onNext(())
        //            button.onNext(())
        //        }
        
//        example(of: "merge") {
//            let sub1 = PublishSubject<String>()
//            let sub2 = PublishSubject<String>()
//
//            _ = Observable.of(sub1, sub2)
//                .merge()
//                .subscribe { str in
//                    print(str)
//                }
//
//            sub1.onNext("iOS 햄쨔기")
//            sub2.onNext("안드 흑마법사")
//            sub1.onNext("iOS 듐보걸")
//            sub2.onNext("안드 이현우")
//            sub1.onNext("iOS 후릐킴")
//            sub2.onNext("안드 조리나")
//
//        }
        
//        example(of: "amb") {
//            let left = PublishSubject<String>()
//            let right = PublishSubject<String>()
//
//            let observable = left.amb(right)
//            let disposable = observable.subscribe(onNext : {value in
//                print(value)
//            })
//
//            left.onNext("몬스타엑스 이민혁")
//            right.onNext("워너원 강다니엘")
//            left.onNext("몬스타엑스 유기현")
//            left.onNext("몬스타엑스 채형원")
//            right.onNext("워너원 박지훈")
//
//            disposable.dispose()
//        }
        
        
//        example(of: "switchLatest") {
//            let northKorea = PublishSubject<String>()
//            let southKorea = PublishSubject<String>()
//            let america = PublishSubject<String>()
//
//            let source = PublishSubject<Observable<String>>()
//
//            let observable = source.switchLatest()
//            let disposable = observable.subscribe(onNext : {value in
//                print(value)
//            })
//
//            source.onNext(northKorea)
//            northKorea.onNext("한반도는 북한이 점령!")
//            southKorea.onNext("안돼 아직...")
//
//            source.onNext(southKorea)
//            southKorea.onNext("한반도 다시 남한이 점령!")
//            northKorea.onNext("아씨.. 맥아더 ㄱㅋㅂㄴ;;")
//
//            source.onNext(america)
//            southKorea.onNext("이제 평화통일할까?")
//            northKorea.onNext("우리 무력통일할까?")
//            america.onNext("뭐래 택도 없지. 너네 통일하면 안됨; 미국이 먹는다.")
//
//            source.onNext(northKorea)
//            northKorea.onNext("아 ㄱㅋㅂㄴ 나 북한 최고 수령 김정은인데 핵 만들었다;")
//
//            disposable.dispose()
//        }
    }
    
}


