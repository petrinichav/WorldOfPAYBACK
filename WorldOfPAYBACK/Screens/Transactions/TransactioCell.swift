//
//  TransactioCell.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import SwiftUI

struct TransactioCell: View {
    @State private var item: Transactions.Item
    
    init(item: Transactions.Item) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(item.partnerDisplayName)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityIdentifier("transaction")
                if let description = item.transactionDetail.description {
                    Spacer()
                    Text(description)
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text(
                    item.transactionDetail.bookingDate,
                    style: .date
                )
                .font(.system(size: 12, weight: .thin))
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
                Text(
                    item.transactionDetail.value.amount,
                    format: .currency(code: item.transactionDetail.value.currency)
                )
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
    }
}

#Preview {
    TransactioCell(item: Transactions.Item.mock)
}
