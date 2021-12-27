//
//  NetworkManager.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import Foundation

final class NetworkManager {
    private let parser = NetworkParser()
}

extension NetworkManager: INetworkManager {
    func fetchStocks(completion: @escaping(() -> Void)) {
        guard let url = URL(string: "https://cloud.iexapis.com/beta/ref-data/symbols?token=pk_f70e895e8492468bb141a20eaf589730") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                  print("fetchStocks: Network error")
                return
            }
            self.parser.parseStocks(data: data)
            completion()
        }
        dataTask.resume();
    }
    
    func requestQuote(for symbol: String, completion: @escaping ((_: Stock)->Void)) {
        let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?&token=pk_f70e895e8492468bb141a20eaf589730")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                  print("requestQuote: Network error")
                return
            }
            
            self.parser.parseQuote(data: data) { stock in
                completion(stock)
            }
        }
        
        dataTask.resume();
    }
    
    func getLogo(for symbol: String, completion: @escaping ((_: Data)->Void)) {
        let url = URL(string: "https://storage.googleapis.com/iex/api/logos/\(symbol).png")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                  print("getLogo: Network error")
                return
            }
            completion(data)
        }
        dataTask.resume();
    }
}
