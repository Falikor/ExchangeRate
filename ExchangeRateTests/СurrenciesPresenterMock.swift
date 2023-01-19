//
//  СurrenciesPresenterMock.swift
//  ExchangeRateTests
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation
@testable import ExchangeRate

class СurrenciesPresenterMock: СurrenciesPresenterProtocol {
    var router: СurrenciesRouterProtocol?
    var result = false
    var interactor: СurrenciesInteractorProtocol?

    var view: СurrenciesViewProtocol?

    func interactorFetchExchange(with result: Result<ExchangeRate.ExchangeModelCore, Error>) {
        switch result {
        case .success(let result):
            view?.updateExchange(with: result)
        case .failure( _ ):
            view?.updateExchangeError(with: "error")
        }
    }

    func interactorFetchAllCurrency(with result: Result<[String]?, Error>) {
        switch result {

        case .success(let result):
            view?.updateAllCurrency(with: result)
        case .failure(_):
            view?.updateExchangeError(with: "error")
        }
    }

    func openChoseExchange() { }

    func getExchange(to: String?, from: String?) { }

    func update() {
        self.result = true
    }
}
