//
//  FirstView.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit
import CoreData

final class FirstView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let searchBarTop: CGFloat = 100
        static let searchBarLeading: CGFloat = 20
        static let searchBarTrailing: CGFloat = -20
        
        static let tableViewRowHeight: CGFloat = 60
        static let tableViewTop: CGFloat = 20
        static let tableViewLeading: CGFloat = 10
        static let tableViewTrailing: CGFloat = -10
        static let tableViewBottom: CGFloat = -20
    }
    
    // MARK: - Properties
    let searchBar = UISearchBar()
    let tableView = UITableView()

    var presenter = FirstPresenter()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - IFirstView
extension FirstView: IFirstView {
    func configView() {
        self.configureSearchBar()
        self.configureTableView()
        
    }
    
    func setNumberOfRowsInSection(with number: Int) -> Int {
        return number
    }
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setDelegate(delegate: UITableViewDelegate) {
        self.tableView.delegate = delegate
    }
}

    // MARK: - Private Methods
private extension FirstView {
    func configureSearchBar() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.delegate = self
        self.addSubview(self.searchBar)
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.topAnchor,
                                                constant: Constants.searchBarTop),
            self.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                    constant: Constants.searchBarLeading),
            self.searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                     constant: Constants.searchBarTrailing)
        ])
    }
    
    func configureTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        self.tableView.dataSource = presenter
        
        self.tableView.rowHeight = Constants.tableViewRowHeight
        self.tableView.register(FirstTableViewCell.self,
                                forCellReuseIdentifier: FirstTableViewCell.idetifier)
        self.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor,
                                                constant: Constants.tableViewTop),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                    constant: Constants.tableViewLeading),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                     constant: Constants.tableViewTrailing),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                        constant: Constants.tableViewBottom)
        ])
    }
}


// MARK: - UISearchBarDelegate
extension FirstView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<CDStock> = CDStock.fetchRequest()
        if let text = searchBar.text {
            let predicate = NSPredicate(format: "name CONTAINS %@", text)
            request.predicate = predicate
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            do {
                try DBModel.cdStocks = context.fetch(request)
            } catch {
                print("FirstView UISearchBarDelegate error \(error)")
            }
            
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            let request: NSFetchRequest<CDStock> = CDStock.fetchRequest()
            do {
                try DBModel.cdStocks = context.fetch(request)
            } catch {
                print("DBModel searchBartextDidChange  error \(error)")
            }
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
