//
//  СurrenciesPresenterProtocol.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation

protocol СurrenciesPresenterProtocol {
    var router: СurrenciesRouterProtocol? { get set }
    var interactor: СurrenciesInteractorProtocol? { get set }
    var view: СurrenciesViewProtocol? { get set }

    func interactorFetchExchange(with result: Result<ExchangeModelCore, Error>)
    func interactorFetchAllCurrency(with result: Result<[String]?, Error>)
    func getExchange(to: String?, from: String?)
    func update()
}
