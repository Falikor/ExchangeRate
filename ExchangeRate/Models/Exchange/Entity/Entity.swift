//
//  ExchangeEntity.swift
//  ExchangeRate
//
//  Created by Бугреев Виктор Викторович on 18.01.2023.
//

import Foundation
import CoreData
import UIKit

// MARK: - EchangeNetworkModel
struct EchangeNetworkModel: Codable, Equatable, Hashable {
    let date: String?
    let info: Info?
    let query: Query?
    let result: Double?
    let success: Bool?
}

// MARK: - Info
struct Info: Codable, Equatable, Hashable {
    let rate: Double?
    let timestamp: Int?
}

// MARK: - Query
struct Query: Codable, Equatable, Hashable {
    let amount: Int?
    let from, to: String?
}

struct EchangeVieModel: Equatable, Hashable {
    let exchangeModelCore: ExchangeModelCore
    var id: NSManagedObjectID {
        return exchangeModelCore.objectID
    }
    var to: String {
        return exchangeModelCore.to ?? ""
    }
    var subTitelTo: String {
        return exchangeModelCore.subTitelTo ?? ""
    }
    var from: String {
        return exchangeModelCore.from ?? ""
    }
    var subTitelFrom: String {
        return exchangeModelCore.subTitelFrom ?? ""
    }
    var result: Double {
        return exchangeModelCore.result
    }
    var exchangeUpDown: String {
        return exchangeModelCore.exchangeUpDown ?? ""
    }
}

enum ExchangeUpDown: String, CaseIterable {
    case red, green, blue

    var wrappedValue: UIColor {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        }
    }
}
