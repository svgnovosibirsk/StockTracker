//
//  IFirstPresenter.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import Foundation
import UIKit

protocol IFirstPresenter {
    func loadView(controller: IFirstViewController, view: IFirstView)
}
