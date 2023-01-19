//
//  ExchangeViewProtocol.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation

protocol ExchangeViewProtocol {
    var presentr: PresenterProtocol? { get set }
    func updateExchange(with exchange: [EchangeVieModel])
    func updateExchangeError(with error: String)
}
