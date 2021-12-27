//
//  DBModel.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit
import CoreData

final class DBModel {
    let networkManager = NetworkManager()
    var onStockRequestFinished: (() -> Void)?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var cdStocks = [CDStock]() 
}

    // MARK: - IDBModel
extension DBModel: IDBModel {
    func getStockRequest() {
        self.loadStocksFromDB()
        guard DBModel.cdStocks.isEmpty else {return}
        networkManager.fetchStocks {
            if let onStockRequestFinished = self.onStockRequestFinished {
                onStockRequestFinished()
            }
        }
    }
    
    func requestQuote(for symbol: String, completion: @escaping ((_: Stock)->Void)) {
        self.networkManager.requestQuote(for: symbol) { stock in
            completion(stock)
        }
    }
    
    func getLogo(for symbol: String, completion: @escaping ((_: Data)->Void)) {
        self.networkManager.getLogo(for: symbol) { data in
            completion(data)
        }
    }
}

    // MARK: - CoreData Methods
extension DBModel {
    func loadStocksFromDB() {
        let request: NSFetchRequest<CDStock> = CDStock.fetchRequest()
        do {
            try DBModel.cdStocks = context.fetch(request)
        } catch {
            print("DBModel loadStocksFromDB error")
        }
    }
}
