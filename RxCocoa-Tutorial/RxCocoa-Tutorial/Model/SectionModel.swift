//
//  SectionModel.swift
//  RxCocoa-Tutorial
//
//  Created by Thisisme Hi on 2021/11/25.
//

import Foundation

import RxDataSources

struct SectionModel {
  var header: String
  var items: [CatchMe]
}

extension SectionModel: SectionModelType {
   init(original: SectionModel, items: [CatchMe]) {
    self = original
    self.items = items
  }
}
