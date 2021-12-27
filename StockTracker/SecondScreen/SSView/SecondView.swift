//
//  SecondView.swift
//  StockTracker
//
//  Created by Sergey Golovin on 25.12.2021.
//

import UIKit

class SecondView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let nameLblNumberOfLines: Int = 5
        static let nameLblFont: CGFloat = 30
        static let nameLblTop: CGFloat = 100
        static let nameLblLeading: CGFloat = 50
        static let nameLblTrailing: CGFloat = -50
        
        static let symbolTxtLblFont: CGFloat = 20
        static let symbolTxtLblTop: CGFloat = 50
        static let symbolTxtLblLeading: CGFloat = 50
        
        static let symbolValueLblFont: CGFloat = 20
        static let symbolValueLblTop: CGFloat = 50
        static let symbolValueLblTrailing: CGFloat = -50
        
        static let priceTxtLblFont: CGFloat = 20
        static let priceTxtLblTop: CGFloat = 50
        static let priceTxtLblLeading: CGFloat = 50
        
        static let priceValueLblFont: CGFloat = 20
        static let priceValueLblTop: CGFloat = 50
        static let priceValueLblTrailing: CGFloat = -50
        
        static let priceChangeTxtLblFont: CGFloat = 20
        static let priceChangeTxtLblTop: CGFloat = 50
        static let priceChangeTxtLblLeading: CGFloat = 50
        
        static let priceChangeValueLblFont: CGFloat = 20
        static let priceChangeValueLblTop: CGFloat = 50
        static let priceChangeValueLblTrailing: CGFloat = -50
        
        static let logoImageViewTop: CGFloat = 50
        static let logoImageViewWidth: CGFloat = 200
        static let logoImageViewHeight: CGFloat = 200
    }
    
    // MARK: - Properties
    var nameLbl = UILabel()
    let symbolTxtLbl = UILabel()
    var symbolValueLbl = UILabel()
    let priceTxtLbl = UILabel()
    var priceValueLbl = UILabel()
    let priceChangeTxtLbl = UILabel()
    var priceChangeValueLbl = UILabel()
    var logoImageView = UIImageView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - ISecondView
extension SecondView: ISecondView {
    func configView() {
        self.configNameLbl()
        self.configSymbolTxtLbl()
        self.configSymbolValueLbl()
        self.configPriceTxtLbl()
        self.configPriceValueLbl()
        self.configPriceChangeTxtLbl()
        self.configPriceChangeValueLbl()
        self.configLogoImageView()
    }
    
    func setViewWith(stock: Stock) {
        DispatchQueue.main.async {
            self.nameLbl.text = stock.name
            self.symbolValueLbl.text = stock.symbol
            
            if let price = stock.latestPrice {
                let formatedPrice = String(format: "%.2f", price)
                self.priceValueLbl.text = "$" + String(formatedPrice)
            }
            
            if let change = stock.change {
                let formatedChange = String(format: "%.2f", change)
                self.priceChangeValueLbl.text = change >= 0 ? "\u{2191} \(formatedChange)%" : "\u{2193} \(formatedChange)%"
                self.priceChangeValueLbl.textColor = change >= 0 ? .systemGreen : .systemRed
            }
        }
    }
    
    func setLogoWith(data: Data) {
        DispatchQueue.main.async {
            self.logoImageView.image = UIImage(data: data)
        }
    }
}

    // MARK: - Private Methods
private extension SecondView {
    func configNameLbl() {
        self.nameLbl.translatesAutoresizingMaskIntoConstraints = false
        self.nameLbl.text = "-"
        self.nameLbl.font = UIFont.boldSystemFont(ofSize: Constants.nameLblFont)
        self.nameLbl.numberOfLines = Constants.nameLblNumberOfLines
        self.nameLbl.textAlignment = .center
        self.addSubview(self.nameLbl)
        
        NSLayoutConstraint.activate([
            self.nameLbl.topAnchor.constraint(equalTo: self.topAnchor,
                                              constant: Constants.nameLblTop),
            self.nameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: Constants.nameLblLeading),
            self.nameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                   constant: Constants.nameLblTrailing),
            self.nameLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func configSymbolTxtLbl() {
        self.symbolTxtLbl.translatesAutoresizingMaskIntoConstraints = false
        self.symbolTxtLbl.text = "Symbol"
        self.symbolTxtLbl.font = UIFont.systemFont(ofSize: Constants.symbolTxtLblFont)
        self.nameLbl.textAlignment = .left
        self.addSubview(self.symbolTxtLbl)
        
        NSLayoutConstraint.activate([
            self.symbolTxtLbl.topAnchor.constraint(equalTo: self.nameLbl.bottomAnchor,
                                                   constant: Constants.symbolTxtLblTop),
            self.symbolTxtLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                       constant: Constants.symbolTxtLblLeading)
        ])
    }
    
    func configSymbolValueLbl() {
        self.symbolValueLbl.translatesAutoresizingMaskIntoConstraints = false
        self.symbolValueLbl.text = "-"
        self.symbolValueLbl.font = UIFont.boldSystemFont(ofSize: Constants.symbolValueLblFont)
        self.symbolValueLbl.textAlignment = .right
        self.addSubview(self.symbolValueLbl)
        
        NSLayoutConstraint.activate([
            self.symbolValueLbl.topAnchor.constraint(equalTo: self.nameLbl.bottomAnchor,
                                                     constant: Constants.symbolValueLblTop),
            self.symbolValueLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                          constant: Constants.symbolValueLblTrailing)
        ])
    }
    
    func configPriceTxtLbl() {
        self.priceTxtLbl.translatesAutoresizingMaskIntoConstraints = false
        self.priceTxtLbl.text = "Price"
        self.priceTxtLbl.font = UIFont.systemFont(ofSize: Constants.priceTxtLblFont)
        self.priceTxtLbl.textAlignment = .left
        self.addSubview(self.priceTxtLbl)
        
        NSLayoutConstraint.activate([
            self.priceTxtLbl.topAnchor.constraint(equalTo: self.symbolValueLbl.bottomAnchor,
                                                  constant: Constants.priceTxtLblTop),
            self.priceTxtLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                      constant: Constants.priceTxtLblLeading)
        ])
    }
    
    func configPriceValueLbl() {
        self.priceValueLbl.translatesAutoresizingMaskIntoConstraints = false
        self.priceValueLbl.text = "-"
        self.priceValueLbl.font = UIFont.boldSystemFont(ofSize: Constants.priceValueLblFont)
        self.priceValueLbl.textAlignment = .right
        self.addSubview(self.priceValueLbl)
        
        NSLayoutConstraint.activate([
            self.priceValueLbl.topAnchor.constraint(equalTo: self.symbolValueLbl.bottomAnchor,
                                                    constant: Constants.priceValueLblTop),
            self.priceValueLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                         constant: Constants.priceValueLblTrailing)
        ])
    }
    
    func configPriceChangeTxtLbl() {
        self.priceChangeTxtLbl.translatesAutoresizingMaskIntoConstraints = false
        self.priceChangeTxtLbl.text = "Price change"
        self.priceChangeTxtLbl.font = UIFont.systemFont(ofSize: Constants.priceChangeTxtLblFont)
        self.priceChangeTxtLbl.textAlignment = .left
        self.addSubview(self.priceChangeTxtLbl)
        
        NSLayoutConstraint.activate([
            self.priceChangeTxtLbl.topAnchor.constraint(equalTo: self.priceTxtLbl.bottomAnchor,
                                                        constant: Constants.priceChangeTxtLblTop),
            self.priceChangeTxtLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                            constant: Constants.priceChangeTxtLblLeading)
        ])
    }
    
    func configPriceChangeValueLbl() {
        self.priceChangeValueLbl.translatesAutoresizingMaskIntoConstraints = false
        self.priceChangeValueLbl.text = "-"
        self.priceChangeValueLbl.font = UIFont.boldSystemFont(ofSize: Constants.priceChangeValueLblFont)
        self.priceChangeValueLbl.textAlignment = .right
        self.addSubview(self.priceChangeValueLbl)
        
        NSLayoutConstraint.activate([
            self.priceChangeValueLbl.topAnchor.constraint(equalTo: self.priceTxtLbl.bottomAnchor,
                                                          constant: Constants.priceChangeValueLblTop),
            self.priceChangeValueLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                               constant: Constants.priceChangeValueLblTrailing)
        ])
    }
    
    func configLogoImageView() {
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.image = UIImage.init(systemName: "photo")
        self.logoImageView.tintColor = .secondarySystemBackground
        self.logoImageView.contentMode = .scaleAspectFit
        self.addSubview(self.logoImageView)
        
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.priceChangeTxtLbl.bottomAnchor,
                                                    constant: Constants.logoImageViewTop),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoImageViewWidth),
            self.logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoImageViewHeight)
        ])
    }
}
