//
//  ContactDetailFeature.swift
//  ContactListTCA
//
//  Created by Márcio Oliveira on 15/07/2023.
//

import Foundation
import ComposableArchitecture

struct ContactDetailFeature: ReducerProtocol {
    struct State: Equatable {
        let contact: Contact
    }
    enum Action: Equatable {
    }
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }
}
