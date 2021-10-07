//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit

protocol ViewModelBindableType {
    // 뷰모델의 타입은 뷰컨마다 달라지기 때문에 제네릭 프로토콜로 선언
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

// 프로토콜 익스텐션 추가
extension ViewModelBindableType where Self: UIViewController {
    // 바인드 뷰모델 메소드를 자동으로 호출하는 메소드를 구현
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}

// 이렇게 해주면 VC에서 하나하나씩 개별적으로 바인드 뷰모델을 안 만들어도 돼서 코드가 간결함
// 이후에 VC에서 프로토콜 채택하면 됨
