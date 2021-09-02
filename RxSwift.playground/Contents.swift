import UIKit
import RxSwift

private var disposeBag = DisposeBag()

Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(2))
    observer.onNext(3)
    
    observer.onCompleted()
    return Disposables.create()
}.subscribe { (event) in
    print(event)
}.disposed(by: disposeBag)

Observable.from([2, 3]).subscribe { event in
    switch event {
    case .next(let value):
        print(value)
    case .error(let error):
        print(error)
    case .completed:
        print("completed")
    }
}.disposed(by: disposeBag)
