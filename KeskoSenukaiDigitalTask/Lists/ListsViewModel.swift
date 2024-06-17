//
//  ListsViewModel.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 04/04/2024.
//

import Foundation
import Services

class ListsViewModel: ObservableObject {
    @Published private(set) var lists: [List] = []
    @Published private(set) var fetchingError: ErrorType? = nil
    private let service: ServiceManaging
    private let coordinator: Coordinating
    private let listsFetcher: AllListsFetcher
    
    init(
        service: ServiceManaging,
        coordinator: Coordinating,
        listsFetcher: AllListsFetcher
    ) {
        self.service = service
        self.coordinator = coordinator
        self.listsFetcher = listsFetcher
        self.listsFetcher.$listPreviews.assign(to: &$lists)
        self.listsFetcher.$fetchingError.assign(to: &$fetchingError)
        updateLists()
    }
    
    func goToList(for listId: Int) {
        coordinator.coordinate(to: .books(listId))
    }
    
    func updateLists() {
        listsFetcher.updateLists()
    }
}
