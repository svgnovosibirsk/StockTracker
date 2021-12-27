//
//  FirstViewController.swift
//  StockTracker
//
//  Created by Sergey Golovin on 19.12.2021.
//

import UIKit

final class FirstViewController: UIViewController {
    
    // MARK: - Properties
    private var firstView: IFirstView
    private var firstPresenter: IFirstPresenter
    
    // MARK: - Initialization
    init() {
        self.firstView = FirstView(frame: UIScreen.main.bounds)
        self.firstPresenter = FirstPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.firstPresenter.loadView(controller: self, view: self.firstView)
        self.firstView.setDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "STOCK TRACKER"
        navigationItem.backButtonTitle = "" 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(firstView)
    }
}

    // MARK: - IFirstViewController
extension FirstViewController: IFirstViewController {

    func moveToSecondScreen(with stock: CDStock) {
        let secondVC = SecondViewController()
        secondVC.stock = stock
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
    // MARK: - UITableViewDelegate
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = DBModel.cdStocks[indexPath.row]
        self.moveToSecondScreen(with: stock)
    }
}
