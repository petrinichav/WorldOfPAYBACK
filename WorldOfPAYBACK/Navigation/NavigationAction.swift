//
//  NavigationAction.swift
//  WorldOfPAYBACK
//
//  Created by Aliaksei Piatrynich on 18/04/2024.
//

import Foundation
import SwiftUI

struct NavigationAction {
    typealias Action = (NavigationType) -> Void
    
    let action: Action
    
    func callAsFunction(_ navigationType: NavigationType) {
        action(navigationType)
    }
}

struct NavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: NavigationAction = NavigationAction(action: { _ in })
}

extension EnvironmentValues {
    var navigate: NavigationAction {
        get { self[NavigationEnvironmentKey.self] }
        set { self[NavigationEnvironmentKey.self] = newValue }
    }
}

extension View {
    func onNavigate(_ action: @escaping NavigationAction.Action) -> some View {
        environment(\.navigate, NavigationAction(action: action))
    }
}
