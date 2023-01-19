//
//  СurrenciesRouter.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation

protocol СurrenciesRouterProtocol: AnyObject {
    func update()
}

class СurrenciesRouter: СurrenciesRouterProtocol {
    weak var viewController: СurrenciesViewController?

    func update() {
        viewController?.navigationController?.popViewController(animated: true)
        viewController?.dismiss(animated: true, completion: nil)
    }
}
