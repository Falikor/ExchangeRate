//
//  СurrenciesPresenter.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation
import UIKit

class СurrenciesPresenter: СurrenciesPresenterProtocol {
    var router: СurrenciesRouterProtocol?

    var interactor: СurrenciesInteractorProtocol? {
        didSet {
            interactor?.getAllCurrency()
        }
    }

    var view: СurrenciesViewProtocol?


    func getExchange(to: String?, from: String?) {
        self.interactor?.getExchange(to: to, from: from)
    }

    func interactorFetchExchange(with result: Result<ExchangeModelCore, Error>) {
        switch result {
        case .success(let currencyPair):
            view?.updateExchange(with: currencyPair)
        case .failure(_):
            view?.updateExchangeError(with: "Что-то пошло не так")
        }
    }

    func interactorFetchAllCurrency(with result: Result<[String]?, Error>) {
        switch result {
        case .success(let allCurrency):
            view?.updateAllCurrency(with: allCurrency)
        case .failure(_):
            view?.updateExchangeError(with: "Что-то пошло не так")
        }
    }

    func update() {
        router?.update()
    }
}

