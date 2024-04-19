//
//  CurrencyFormatModifier.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import SwiftUI

struct CurrencyFormatModifier: ViewModifier {
    var amount: Double
    var code: String

    func body(content: Content) -> some View {
        Text(CurrencyFormatter(currency: code).format(amount))
    }
}

extension View {
    func currencyFormat(amount: Double, code: String) -> some View {
        modifier(CurrencyFormatModifier(amount: amount, code: code))
    }
}
