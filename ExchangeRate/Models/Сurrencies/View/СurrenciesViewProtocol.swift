//
//  СurrenciesViewProtocol.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation

protocol СurrenciesViewProtocol {
    var presentr: СurrenciesPresenterProtocol? { get set }
    func updateExchange(with exchange: ExchangeModelCore)
    func updateExchangeError(with error: String)
    func updateAllCurrency(with allCurrency: [String]?)
}
