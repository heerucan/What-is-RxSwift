//
//  Scene.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit

enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

// 스토리보드에서 있는 scene을 생성하고 연관값에 저장된 뷰모델을 바인딩해서 리턴하는 메소드
extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav")
                    as? UINavigationController else {
                        fatalError()
                    }
            
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                 fatalError()
            }
            
            listVC.bind(viewModel: viewModel)
            return nav
            
        case .detail(let viewModel):
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC")
                    as? MemoDetailViewController else {
                        fatalError()
                    }
            
            detailVC.bind(viewModel: viewModel)
            return detailVC
            
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav")
                    as? UINavigationController else {
                        fatalError()
                    }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                        fatalError()
                    }
            
            composeVC.bind(viewModel: viewModel)
            return nav
        }
        
    }
}

