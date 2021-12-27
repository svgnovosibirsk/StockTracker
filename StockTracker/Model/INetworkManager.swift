//
//  INetworkManager.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import Foundation

protocol INetworkManager {
    func fetchStocks(completion: @escaping(() -> Void))
    func requestQuote(for symbol: String, completion: @escaping ((_: Stock)->Void))
    func getLogo(for symbol: String, completion: @escaping ((_: Data)->Void))
}
