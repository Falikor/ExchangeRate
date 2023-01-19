//
//  CurrenciesEntity.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 19.01.2023.
//

import Foundation

// MARK: - AllCurrency
struct AllCurrency: Codable, Equatable, Hashable {
    let success: Bool?
    let symbols: [String: String]?
}
