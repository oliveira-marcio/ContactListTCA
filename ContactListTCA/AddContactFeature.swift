//
//  AddContactFeature.swift
//  ContactListTCA
//
//  Created by Márcio Oliveira on 13/07/2023.
//

import Foundation
import ComposableArchitecture

struct AddContactFeature: ReducerProtocol {
    struct State: Equatable {
        var contact: Contact
    }
    enum Action: Equatable {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .cancelButtonTapped:
            return .none

        case .saveButtonTapped:
            return .none

        case let .setName(name):
            state.contact.name = name
            return .none
        }
    }
}