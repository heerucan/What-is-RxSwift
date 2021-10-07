//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
