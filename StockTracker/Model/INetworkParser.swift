//
//  INetworkParser.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import Foundation

protocol INetworkParser {
    func parseStocks(data: Data)
    func parseQuote(data: Data, completion: @escaping ((_: Stock)->Void))
}
