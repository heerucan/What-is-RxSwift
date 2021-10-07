//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import Foundation
import RxSwift

// 메모리에 메모를 저장
class MemoryStorage: MemoStorageType {
    
    // 메모를 저장할 배열
    // 클래스 외부에서 배열에 직접 접근할 필요가 없기 때문에 private으로 선언
    // 이 배열은 observable을 통해 외부로 공개
    // -> 그리고 이 observable은 배열의 상태가 업데이트 되면 새로운 next event를 방출해야 한다.
    private var list = [
        Memo(content: "Hello", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Ruhee", insertDate: Date().addingTimeInterval(-20))
    ]

    // 근데 그냥 observable 형태면 불가능해서 subject(multicast 형식)로 만들어야 한다.
    // 그리고 초기에 더미데이터를 표시해야 하니까 BehaviorSubject로 만들어 준다.
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
        
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        // 새로운 메모를 생성하고 배열에 추가
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        // subject에서 새로운 next event 방출
        store.onNext(list)
        
        // 새로운 메모를 방출하는 옵저버블 리턴
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        // update된 메모 인스턴스 하나 생성
        let updated = Memo(original: memo, updatedContent: content)
        
        // 배열에 저장된 원본 인스턴스를 새로운 인스턴스로 교체
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        // 여기에서는 리스트 배열에서 메모를 삭제하고 subject에서 새로운 next event 방출
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        // 삭제된 메모 방출하는 옵저버블
        return Observable.just(memo)
    }
}

// 배열을 변경한 다음에 subject에서 새로운 next event를 방출하는 형식으로 되어 있음
