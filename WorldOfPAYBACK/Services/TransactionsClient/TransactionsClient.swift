//
//  TransactionsClient.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 17/04/2024.
//

import Foundation
import SwiftUI

@MainActor
final class TransactionsClient: ObservableObject {
    private let networkingClient: NetworkClientable
    private var transactions: [Transactions.Item] = []
    
    @Published var selectedFilter = Set<Int>()
    @Published var filteredTransactions: [Transactions.Item] = []
    @Published var isLoading = false
    @Published var totalAmount: Transactions.Value?
    @Published var filter: Set<Int> = []
    
    var hasTransactions: Bool {
        !transactions.isEmpty
    }
    
    init(networkingClient: NetworkClientable) {
        self.networkingClient = networkingClient
    }
    
    func fetchTransactions() async throws {
        isLoading = true
        defer {
            isLoading = false
        }
        
        let allTransactions: Transactions = try await networkingClient.run(request: .transactions)
        transactions = sorted(transactions: allTransactions) ?? []
        filteredTransactions = transactions
        
        guard !transactions.isEmpty else {
            return
        }
        totalAmount = totalAmount(from: transactions)
        
        filter = Set(transactions.map { $0.category }.sorted())
        selectedFilter = filter
    }
    
    func filtered(by category: Int) {
        if selectedFilter.contains(category) {
            selectedFilter.remove(category)
        } else {
            selectedFilter.insert(category)
        }
        
        if selectedFilter.isEmpty {
            filteredTransactions = []
        } else {
            filteredTransactions = transactions.filter {
                selectedFilter.contains($0.category)
            }
        }
        
        totalAmount = totalAmount(from: self.filteredTransactions)
    }
}

private extension TransactionsClient {
    func sorted(transactions: Transactions) -> [Transactions.Item]? {
        return transactions.items.sorted { item1, item2 in
            item1.transactionDetail.bookingDate > item2.transactionDetail.bookingDate
        }
    }
    
    func totalAmount(from items: [Transactions.Item]) -> Transactions.Value {
        let currency = items.first?.transactionDetail.value.currency ?? Locale.current.currency?.identifier ?? ""
        
        let amount: Int = items.reduce(0) { result, transaction in
            var sum = result
            sum += transaction.transactionDetail.value.amount
            return sum
        }
        
        return Transactions.Value(amount: amount, currency: currency)
    }
}
