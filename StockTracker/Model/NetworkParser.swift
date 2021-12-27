//
//  NetworkParser.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit
import CoreData

final class NetworkParser {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

extension NetworkParser: INetworkParser {
    func parseStocks(data: Data) {
        let decoder = JSONDecoder()
        
        if let stocks = try? decoder.decode([Stock].self, from: data) {
            var cdStocks = [CDStock]()
            for stock in stocks {
                let cdStock = CDStock(context: context)
                cdStock.name = stock.name
                cdStock.symbol = stock.symbol
                cdStock.latestPrice = 0
                cdStock.change = 0
                cdStocks.append(cdStock)
            }
            
            DBModel.cdStocks = cdStocks
        }
    }
    
    func parseQuote(data: Data, completion: @escaping ((_: Stock)->Void)) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double
                else {
                    print("! Invalid JSON format")
                    return
                }
            let stock = Stock(symbol: companySymbol,
                              name: companyName,
                              latestPrice: price,
                              change: priceChange)
            completion(stock)
        } catch {
            print("! JSON parsing error: " + error.localizedDescription)
        }
    }
}
