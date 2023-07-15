//
//  ContactListTCAApp.swift
//  ContactListTCA
//
//  Created by Márcio Oliveira on 13/07/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct ContactListTCAApp: App {
    static let store = Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            ContactsView(store: ContactListTCAApp.store)
        }
    }
}
