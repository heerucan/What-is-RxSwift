//
//  TransitionModel.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
