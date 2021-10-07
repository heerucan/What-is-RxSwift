//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import Foundation

import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
