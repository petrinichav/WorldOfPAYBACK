//
//  DataFormatter.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import Foundation
import SwiftUI

final class CurrencyFormatter {
    private let currency: String
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencyCode = currency
        formatter.locale = Locale.current
        return formatter
    }()
    
    init(currency: String) {
        self.currency = currency
    }
    
    func format(_ value: Double) -> String {
        formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
