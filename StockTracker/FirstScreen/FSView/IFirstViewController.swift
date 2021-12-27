//
//  IFirstViewController.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit

protocol IFirstViewController: NSObject {
    func moveToSecondScreen(with stock: CDStock)
}
