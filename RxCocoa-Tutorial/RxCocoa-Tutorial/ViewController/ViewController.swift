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
    
    private let catchme = [CatchmeModel(name: "김루희", part: Part.iOS),
                   CatchmeModel(name: "김준희", part: Part.Design),
                   CatchmeModel(name: "김서진", part: Part.Android),
                   CatchmeModel(name: "이현우", part: Part.Android),
                   CatchmeModel(name: "신윤아", part: Part.iOS),
                   CatchmeModel(name: "양수빈", part: Part.iOS),
                   CatchmeModel(name: "조승희", part: Part.Android),
                   CatchmeModel(name: "조승우", part: Part.Design),
                   CatchmeModel(name: "명세린", part: Part.Plan),
                   CatchmeModel(name: "김해리", part: Part.Plan),
                   CatchmeModel(name: "마예지", part: Part.Design),
                   CatchmeModel(name: "최영재", part: Part.Server),
                   CatchmeModel(name: "권세훈", part: Part.Server)]
    
    /// catchme 리스트 데이터를 옵저버블로 바꿔주기 - 관찰가능한 형태
    private lazy var catchmeObservable = Observable.of(catchme)

    // MARK: - @IBOutlet
    
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainTV: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    // MARK: - Custom Method
    
    // Model은 Observable / VC은 Observer

    func setTableView() {
        
        /// Datasource 부분
        catchmeObservable
            .bind(to: mainTV.rx.items(cellIdentifier: MainTableViewCell.cellID,
                                      cellType: MainTableViewCell.self)) {
                row, element, cell in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = "\(element.part)"
            }.disposed(by: disposeBag)
        
        /// Delegate 부분
        mainTV.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.mainTV.deselectRow(at: indexPath, animated: true)
                guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
                        as? DetailViewController else { return }
                detailVC.nameText = self.catchme[indexPath.row].name
                detailVC.partText = "\(self.catchme[indexPath.row].part)"
                detailVC.modalPresentationStyle = .overFullScreen
                self.present(detailVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}
