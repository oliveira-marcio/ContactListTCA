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
        case delegate(Delegate)
        case setName(String)
        enum Delegate: Equatable {
            case saveContact(Contact)
        }
    }
    @Dependency(\.dismiss) var dismiss
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .cancelButtonTapped:
            return .run { _ in await self.dismiss() }

        case .saveButtonTapped:
            return .run { [contact = state.contact] send in
                await send(.delegate(.saveContact(contact)))
                await self.dismiss()
            }

        case .delegate:
            return .none

        case let .setName(name):
            state.contact.name = name
            return .none
        }
    }
}
