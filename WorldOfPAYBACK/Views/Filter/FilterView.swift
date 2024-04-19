//
//  FilterView.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 19/04/2024.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject private var transactionClient: TransactionsClient

    var body: some View {
        List(transactionClient.filter.toArray(), id: \.self) { category in
            Button {
                transactionClient.filtered(by: category)
            } label: {
                HStack {
                    Text("\(category)")
                        .fontWeight(.bold)
                    Spacer()
                    if transactionClient.selectedFilter.contains(category) {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

extension Set where Element: Comparable {
    func toArray() -> [Element] {
        Array(self).sorted()
    }
}
