//
//  Store.swift
//  athena-ios
//
//  Created by annatar.he on 2019/9/23.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//
// https://github.com/mecid/redux-like-state-container-in-swiftui/blob/master/GithubSearch/Store.swift
import Foundation
import Combine

protocol Action {
    associatedtype Mutation
    func mapToMutation() -> AnyPublisher<Mutation, Never>
}

typealias Reducer<State, Mutation> = (inout State, Mutation) -> Void

final class Store<AppState, AppAction: Action>: ObservableObject {
    @Published private(set) var state: AppState
    
    private let appReducer: Reducer<AppState, AppAction.Mutation>
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        initialState: AppState,
        appReducer: @escaping Reducer<AppState, AppAction.Mutation>
    ) {
        self.state = initialState
        self.appReducer = appReducer
    }
    
    func send(_ action: AppAction) {
        action
            .mapToMutation()
            .receive(on: DispatchQueue.main)
            .sink { self.appReducer(&self.state, $0) }
            .store(in: &cancellables)
    }
}
