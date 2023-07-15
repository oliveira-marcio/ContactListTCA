//
//  ContactsFeature.swift
//  ContactListTCA
//
//  Created by Márcio Oliveira on 13/07/2023.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

struct ContactsFeature: ReducerProtocol {
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
        @PresentationState var destination: Destination.State?
    }
    enum Action: Equatable {
        case addButtonTapped
        case deleteButtonTapped(id: Contact.ID)
        case destination(PresentationAction<Destination.Action>)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.destination = .addContact(
                    AddContactFeature.State(
                        contact: Contact(id: UUID(), name: "")
                    )
                )
                return .none

            case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
                state.contacts.append(contact)
                return .none

            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none

            case .destination(.presented(.addContact(.cancelButtonTapped))):
                return .none

            case .destination(.presented(.addContact(.saveButtonTapped))):
                return .none

            case .destination(.presented(.addContact(.setName(_)))):
                return .none
                
            case .destination(.dismiss):
                return .none

            case let .deleteButtonTapped(id: id):
                state.destination = .alert(
                    AlertState {
                        TextState("Are you sure?")
                    } actions: {
                        ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                            TextState("Delete")
                        }
                    }
                )
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}

extension ContactsFeature {
    struct Destination: ReducerProtocol {
        enum State: Equatable {
            case addContact(AddContactFeature.State)
            case alert(AlertState<ContactsFeature.Action.Alert>)
        }
        enum Action: Equatable {
            case addContact(AddContactFeature.Action)
            case alert(ContactsFeature.Action.Alert)
        }
        var body: some ReducerProtocolOf<Self> {
            Scope(state: /State.addContact, action: /Action.addContact) {
                AddContactFeature()
            }
        }
    }
}
