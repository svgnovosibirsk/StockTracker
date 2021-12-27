//
//  Stock.swift
//  StockTracker
//
//  Created by Sergey Golovin on 20.12.2021.
//

import Foundation

class Stock: Decodable {
    let symbol: String
    let name: String
    let latestPrice: Double?
    let change: Double?
    
    init(symbol: String, name: String, latestPrice: Double?, change: Double?) {
        self.symbol = symbol
        self.name = name
        self.latestPrice = latestPrice
        self.change = change
    }
}
