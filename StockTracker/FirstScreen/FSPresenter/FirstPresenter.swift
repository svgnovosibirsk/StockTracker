//
//  FirstPresenter.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit


final class FirstPresenter: NSObject {
    private let model = DBModel()
    private weak var controller: IFirstViewController?
    private weak var view: IFirstView?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

    // MARK: - IFirstPresenter
extension FirstPresenter: IFirstPresenter {
    func loadView(controller: IFirstViewController, view: IFirstView) {
        self.controller = controller
        self.view = view
        self.view?.configView()
        self.model.getStockRequest()
        self.setHandlers()
    }
}
    // MARK: - Private Methods
private extension FirstPresenter {
    private func updateView() {
        self.view?.update()
    }
    private func setHandlers() {
        self.model.onStockRequestFinished = { [weak self] in
            self?.saveStocks()
        }
    }
}

    // MARK: - UITableViewDataSource
extension FirstPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DBModel.cdStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.idetifier, for: indexPath) as! FirstTableViewCell
        cell.textLabel?.text = DBModel.cdStocks[indexPath.row].name
        cell.textLabel?.numberOfLines = 2
        cell.backgroundColor = indexPath.row.isMultiple(of: 2) ? .secondarySystemBackground : .white

        return cell
    }
}

    // MARK: - Core Data Methods
extension FirstPresenter {
    func saveStocks() {
        do {
            try context.save()
        } catch {
            print("FirstPresenter: saving context error")
        }
        
        self.view?.update()
    }
}
