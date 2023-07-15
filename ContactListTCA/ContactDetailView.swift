//
//  ContactDetailView.swift
//  ContactListTCA
//
//  Created by Márcio Oliveira on 15/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
            }
            .navigationBarTitle(Text(viewStore.contact.name))
        }
    }
}

struct ContactDetailPreviews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactDetailView(
                store: Store(
                    initialState: ContactDetailFeature.State(
                        contact: Contact(id: UUID(), name: "Blob")
                    )
                ) {
                    ContactDetailFeature()
                }
            )
        }
    }
}
