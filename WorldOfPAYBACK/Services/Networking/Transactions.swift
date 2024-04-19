import Foundation

// MARK: - Transactions
struct Transactions: Codable {
    let items: [Item]
}

// MARK: - Item
extension Transactions {
    struct Item: Codable, Identifiable, Hashable {
        var id = UUID().uuidString
        
        let partnerDisplayName: String
        let alias: Alias
        let category: Int
        let transactionDetail: Details
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(partnerDisplayName)
            hasher.combine(alias)
            hasher.combine(category)
            hasher.combine(transactionDetail)
        }
        
        enum CodingKeys: String, CodingKey {
            case partnerDisplayName
            case alias
            case category
            case transactionDetail
        }
    }
}

// MARK: - Alias
extension Transactions {
    struct Alias: Codable, Hashable {
        let reference: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(reference)
        }
    }
}

// MARK: - TransactionDetail
extension Transactions {
    struct Details: Codable, Hashable {
        let description: String?
        let bookingDate: Date
        let value: Value
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(description)
            hasher.combine(bookingDate)
            hasher.combine(value)
        }
    }
}

// MARK: - Value
extension Transactions {
    struct Value: Codable, Hashable {
        let amount: Int
        let currency: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(amount)
            hasher.combine(currency)
        }
    }
}
