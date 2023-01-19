//
//  Router.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func present()
}


class ExchangeRouter: RouterProtocol {
    weak var viewController: ExchangeViewController?
    func present() {
        let vc = СurrenciesBilder.bild()
        viewController?.show(vc, sender: nil)
    }
}

class ExchangeBilder {
    static func start() -> ExchangeViewController {
        let router = ExchangeRouter()
        let view = ExchangeViewController()
        let interactor = ExchangeInteractor()
        let presenter = ExchangePresenter()
        view.presentr = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.viewController = view
        return view
    }
}
