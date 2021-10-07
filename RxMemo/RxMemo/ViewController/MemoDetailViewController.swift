//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class MemoDetailViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MemoDetailViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)
        
        editButton.rx.action = viewModel.makeEditAction()
    }
}
