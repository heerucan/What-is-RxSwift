//
//  CatchmeModel.swift
//  RxCocoa-Tutorial
//
//  Created by Thisisme Hi on 2021/11/24.
//

import Foundation

enum Part: String {
    case iOS = "iOS Dev"
    case Android = "Android Dev"
    case Plan = "Plan"
    case Design = "Designer"
    case Server = "Server Dev"
}

struct CatchmeModel {
    var name: String
    var part: Part
}
