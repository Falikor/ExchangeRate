//
//  Presenter.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import UIKit

class ExchangePresenter: PresenterProtocol {
    
    var router: RouterProtocol?
    var interactor: InteractorProtocol?
    var view: ExchangeViewProtocol?

    func interactorFetchExchange(with result: Result<[EchangeVieModel], Error>) {
        switch result {
        case .success(let currencyPair):
            view?.updateExchange(with: currencyPair)
        case .failure(_):
            view?.updateExchangeError(with: "Что-то пошло не так")
        }
    }

    func startTaimer() {
        interactor?.updateStartTimer()
    }

    func getEchangeVieModel() -> [EchangeVieModel] {
        interactor?.getAllExchangeModelCore() ?? []
    }

    func delete(_ iteam: EchangeVieModel) {
        interactor?.delete(iteam)
    }
    
    func openChoseExchange() {
        router?.present()
    }
}
