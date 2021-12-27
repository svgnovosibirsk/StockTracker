//
//  IFirstView.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit

protocol IFirstView: UIView {
    func configView()
    func setNumberOfRowsInSection(with number: Int) -> Int
    func update()
    func setDelegate(delegate: UITableViewDelegate)
}
