//
//  СurrenciesBilder.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation

class СurrenciesBilder {
    static func bild() -> СurrenciesViewController {
        let router = СurrenciesRouter()
        let view = СurrenciesViewController()
        let interactor = СurrenciesInteractor()
        let presenter = СurrenciesPresenter()
        view.presentr = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        return view
    }
}
