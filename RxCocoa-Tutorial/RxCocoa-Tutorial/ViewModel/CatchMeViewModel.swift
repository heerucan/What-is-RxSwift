//
//  CatchMeViewModel.swift
//  RxCocoa-Tutorial
//
//  Created by Thisisme Hi on 2021/11/25.
//

import Foundation

import RxCocoa
import RxSwift

struct CatchMeViewModel {
    var catchMeList = PublishSubject<[CatchMe]>()
    
    func fetchCatchMeList() {
        let catchme = [CatchMe(name: "김루희", part: Part.iOS),
                       CatchMe(name: "신윤아", part: Part.iOS),
                       CatchMe(name: "양수빈", part: Part.iOS),
                       CatchMe(name: "명세린", part: Part.Plan),
                       CatchMe(name: "김해리", part: Part.Plan),
                       CatchMe(name: "김준희", part: Part.Design),
                       CatchMe(name: "김서진", part: Part.Android),
                       CatchMe(name: "이현우", part: Part.Android),
                       CatchMe(name: "조승희", part: Part.Android),
                       CatchMe(name: "조승우", part: Part.Design),
                       CatchMe(name: "마예지", part: Part.Design),
                       CatchMe(name: "최영재", part: Part.Server),
                       CatchMe(name: "권세훈", part: Part.Server)]
        
        catchMeList.onNext(catchme)
        catchMeList.onCompleted()
    }
    
    /// catchme 리스트 데이터를 옵저버블로 바꿔주기 - 관찰가능한 형태
    private lazy var catchmeObservable = Observable.of(catchMeList)
}
