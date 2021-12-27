//
//  ISecondView.swift
//  StockTracker
//
//  Created by Sergey Golovin on 25.12.2021.
//

import UIKit

protocol ISecondView: UIView {
    func configView()
    func setViewWith(stock: Stock)
    func setLogoWith(data: Data)
}
