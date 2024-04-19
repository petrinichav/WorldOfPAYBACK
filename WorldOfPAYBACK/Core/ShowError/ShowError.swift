//
//  ShowError.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import SwiftUI

struct ErrorWrapper: Identifiable {
    var id = UUID()
    
    let error: Error
    var description: String {
        if let localizedError = error as? LocalizedError {
            localizedError.errorDescription ?? localizedError.localizedDescription
        } else {
            error.localizedDescription
        }
    }
}

struct ShowErrorEnvironmentKey: EnvironmentKey {
    static var defaultValue: (Error) -> Void = { _ in }
}

extension EnvironmentValues {
    var showError: (Error) -> Void {
        get { self[ShowErrorEnvironmentKey.self] }
        set { self[ShowErrorEnvironmentKey.self] = newValue }
    }
}
