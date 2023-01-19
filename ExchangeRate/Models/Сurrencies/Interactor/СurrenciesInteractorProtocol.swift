//
//  СurrenciesInteractorProtocol.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation

protocol СurrenciesInteractorProtocol {
    var presenter: СurrenciesPresenterProtocol? { get set }
    func getExchange(to: String?, from: String?)
    func getAllCurrency()
}

