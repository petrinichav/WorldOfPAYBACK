//
//  TransactionDetailsScreen.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import SwiftUI

struct TransactionDetailsScreen: View {
    @State private var item: Transactions.Item
    
    init(item: Transactions.Item) {
        self.item = item
    }
    
    var body: some View {
        Form {
            Text(item.transactionDetail.description ?? "")
                .fontWeight(.regular)
                .foregroundStyle(.gray)
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .navigationTitle(item.partnerDisplayName)
        .foregroundStyle(.brown)
    }
}

#Preview {
    TransactionDetailsScreen(item: Transactions.Item.mock)
}
