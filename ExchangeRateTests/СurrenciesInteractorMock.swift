//
//  СurrenciesInteractorMock.swift
//  ExchangeRateTests
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation
@testable import ExchangeRate

class СurrenciesInteractorMock: СurrenciesInteractorProtocol {
    var presenter: СurrenciesPresenterProtocol?

    func getExchange(to: String?, from: String?) {
        presenter?.interactorFetchExchange(with: .success(ExchangeModelCore.init()))
    }

    func getAllCurrency() {
        presenter?.interactorFetchAllCurrency(with: .success(["1", "2"]))
    }
}
