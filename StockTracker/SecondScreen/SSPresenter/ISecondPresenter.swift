//
//  ISecondPresenter.swift
//  StockTracker
//
//  Created by Sergey Golovin on 25.12.2021.
//

import Foundation

protocol ISecondPresenter {
    func loadView(controller: ISecondViewController, view: ISecondView)
    func requestQuote(for symbol: String)
    func getLogo(for symbol: String)
}
