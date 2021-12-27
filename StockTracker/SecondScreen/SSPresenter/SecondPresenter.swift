//
//  SecondPresenter.swift
//  StockTracker
//
//  Created by Sergey Golovin on 25.12.2021.
//

import Foundation

final class SecondPresenter: NSObject {
    private let model = DBModel()
    private weak var controller: ISecondViewController?
    private weak var view: ISecondView?
}

extension SecondPresenter: ISecondPresenter {
    func loadView(controller: ISecondViewController, view: ISecondView) {
        self.controller = controller
        self.view = view
        self.view?.configView()
    }
    
    func requestQuote(for symbol: String) {
        self.model.requestQuote(for: symbol) { stock in
            self.view?.setViewWith(stock: stock)
        }
    }
    
    func getLogo(for symbol: String) {
        self.model.getLogo(for: symbol) { data in
            self.view?.setLogoWith(data: data)
        }
    }
}
