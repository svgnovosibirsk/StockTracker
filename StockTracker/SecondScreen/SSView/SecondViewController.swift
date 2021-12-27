//
//  SecondViewController.swift
//  StockTracker
//
//  Created by Sergey Golovin on 25.12.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    // MARK: - Properties
    private var secondView: ISecondView
    private var secondPresenter: ISecondPresenter
    
    var stock: CDStock?
    
    // MARK: - Initialization
    init() {
        self.secondView = SecondView(frame: UIScreen.main.bounds)
        self.secondPresenter = SecondPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.secondPresenter.loadView(controller: self, view: self.secondView)
        self.secondPresenter.requestQuote(for: self.stock?.symbol ?? "A")
        self.secondPresenter.getLogo(for: self.stock?.symbol ?? "A")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(secondView)
    }
}

extension SecondViewController: ISecondViewController {
    
}
