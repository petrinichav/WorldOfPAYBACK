//
//  TransactionItemMock.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import Foundation

extension Transactions.Item {
    static var mock: Self {
        Self(
            partnerDisplayName: "Test",
            alias: Transactions.Alias(reference: ""),
            category: 0,
            transactionDetail: Transactions.Details(
                description: "Description",
                bookingDate: Date(),
                value: Transactions.Value(amount: 10, currency: "USD")
            )
        )
    }
}
