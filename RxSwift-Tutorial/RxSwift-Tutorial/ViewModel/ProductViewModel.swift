//
//  ProductViewModel.swift
//  RxSwift-Tutorial
//
//  Created by Thisisme Hi on 2021/09/02.
//

import Foundation

import RxCocoa
import RxSwift

struct ProductViewModel {
    var productList = PublishSubject<[Product]>()
    
    func fetchProductList() {
        let products = [
            Product(imageName: "house", title: "House"),
            Product(imageName: "gear", title: "Setting"),
            Product(imageName: "person.circle", title: "Profile"),
            Product(imageName: "airplane", title: "Flights"),
            Product(imageName: "bell", title: "Activity")
        ]
        
        productList.onNext(products)
        productList.onCompleted()
    }
}
