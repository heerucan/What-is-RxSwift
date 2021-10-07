//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    //기본적인 CRUD 처리 메소드 작성
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
