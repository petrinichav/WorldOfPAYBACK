//
//  TransactionsScreen.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import SwiftUI

struct TransactionsScreen: View {
    @EnvironmentObject private var transactionClient: TransactionsClient
    @Environment(\.navigate) var navigate
    @Environment(\.showError) private var showError
    
    @State private var showFilter = false
    
    var body: some View {
        VStack {
            if transactionClient.hasTransactions {
                Button("button.filter") {
                    showFilter = true
                }
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .popover(isPresented: $showFilter, content: {
                    FilterView().environmentObject(transactionClient)
                })
                .padding()
                
                if (transactionClient.filteredTransactions.isEmpty) {
                    Spacer(minLength: 10)
                }
            }
            if transactionClient.isLoading && !transactionClient.hasTransactions {
                ProgressView("loading.title")
                
            } else if !transactionClient.filteredTransactions.isEmpty {
                List(transactionClient.filteredTransactions) { item in
                    TransactioCell(item: item)
                        .onTapGesture {
                            navigate(.push(.details(item)))
                        }
                }.refreshable {
                    await loadTransactions()
                }
            } else {
                Spacer()
                Text("transactions.text.nodata")
                    .foregroundStyle(.green)
                    .padding()
                    .accessibilityIdentifier("noData")
                if !transactionClient.hasTransactions {
                    Button("button.load") {
                        Task {
                            await loadTransactions()
                        }
                    }
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.red)
                    .accessibilityIdentifier("loadButton")
                }
                Spacer()
            }
            
            HStack {
                if let totalValue = transactionClient.totalAmount,
                      totalValue.amount > 0 {
                    Text("transactions.label.totalAmount")
                        .fontWeight(.medium)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(
                        totalValue.amount,
                        format: .currency(code: totalValue.currency)
                    )
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }.padding()
        }
        .navigationTitle("transactions.title")
        .foregroundStyle(.brown)
        .task {
            await loadTransactions()
        }
    }
    
    private func loadTransactions() async {
        do {
            try await transactionClient.fetchTransactions()
        } catch {
            showError(error)
        }
    }
}

#Preview("English") {
    TransactionsScreen()
        .environmentObject(
            TransactionsClient(
                networkingClient: NetworkClientMock(
                    expectedResult: .success(Void())
                )
            )
        )
}

#Preview("Polish") {
    TransactionsScreen()
        .environmentObject(
            TransactionsClient(
                networkingClient: NetworkClientMock(
                    expectedResult: .success(Void())
                )
            )
        ).environment(\.locale, .init(identifier: "pl"))
}

#Preview("NoData") {
    TransactionsScreen()
        .environmentObject(
            TransactionsClient(
                networkingClient: NetworkClientMock(
                    expectedResult: .failure(.someError)
                )
            )
        )
}
