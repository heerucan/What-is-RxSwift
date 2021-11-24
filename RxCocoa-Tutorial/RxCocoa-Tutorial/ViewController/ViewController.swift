//
//  ViewController.swift
//  RxCocoa-Tutorial
//
//  Created by Thisisme Hi on 2021/11/18.
//

import UIKit

import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var disposeBag = DisposeBag()
    
    private var searchedText = [CatchMe]()
    
    private let tableViewItems = [CatchMe(name: "김루희", part: Part.iOS),
                                  CatchMe(name: "김준희", part: Part.Design),
                                  CatchMe(name: "김서진", part: Part.Android),
                                  CatchMe(name: "이현우", part: Part.Android),
                                  CatchMe(name: "신윤아", part: Part.iOS),
                                  CatchMe(name: "양수빈", part: Part.iOS),
                                  CatchMe(name: "조승희", part: Part.Android),
                                  CatchMe(name: "조승우", part: Part.Design),
                                  CatchMe(name: "명세린", part: Part.Plan),
                                  CatchMe(name: "김해리", part: Part.Plan),
                                  CatchMe(name: "마예지", part: Part.Design),
                                  CatchMe(name: "최영재", part: Part.Server),
                                  CatchMe(name: "권세훈", part: Part.Server)]
    
    /// catchme 리스트 데이터를 옵저버블로 바꿔주기 - 관찰가능한 형태
    private lazy var catchmeObservable = BehaviorRelay.init(value: tableViewItems)
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainTV: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    // MARK: - Custom Method
    
    /// Model은 Observable / VC은 Observer
    
    func setTableView() {
        
        _ = mainSearchBar.rx.text.orEmpty
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({ text in
                self.catchmeObservable.value.filter({ catchMePerson in
                    text.isEmpty || catchMePerson.name.lowercased().contains(text.lowercased())
                })
            }).bind(to: mainTV
                    .rx
                    .items(cellIdentifier: MainTableViewCell.cellID,
                                      cellType: MainTableViewCell.self)) {
                row, element, cell in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = "\(element.part)"
            }.disposed(by: disposeBag)
        
        
        /// Delegate 부분
        mainTV
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self]
                indexPath in
                guard let self = self else { return }
                self.mainTV.deselectRow(at: indexPath, animated: true)
            }).disposed(by: disposeBag)
        
        
        mainTV
            .rx
            .modelSelected(CatchMe.self)
            .subscribe(onNext: { [unowned self]
                catchmeData in
                let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
                as! DetailViewController
                detailVC.nameText = catchmeData.name
                detailVC.partText = "\(catchmeData.part)"
                detailVC.modalPresentationStyle = .overFullScreen
                self.present(detailVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}
