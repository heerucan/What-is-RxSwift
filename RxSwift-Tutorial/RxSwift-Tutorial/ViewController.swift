//
//  ViewController.swift
//  RxSwift-Tutorial
//
//  Created by Thisisme Hi on 2021/09/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class ViewController: UIViewController {
    // MARK: - Properties
    private var bag = DisposeBag()
    
    private var viewModel = ProductViewModel()
    
    private let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setupTableView()
    }
    
    // MARK: - Custom Method
    func setupAutoLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        bindTableData()
    }
    
    func bindTableData() {
        // 1. bind items to table
        viewModel.productList.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
        
        // 2. bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
        }.disposed(by: bag)
        
        // 3. fetch items
        viewModel.fetchProductList()
    }
}
