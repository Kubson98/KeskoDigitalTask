//
//  BooksViewModel.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 07/04/2024.
//

import Foundation
import Services

class BooksViewModel: ObservableObject {
    @Published private(set) var booksResult: [Book] = []
    @Published private(set) var fetchingError: FetchingError? = nil
    private let service: ServiceManaging
    private let coordinator: Coordinating
    private let booksFetcher: BooksFetcher
    
    init(
        service: ServiceManaging,
        coordinator: Coordinating,
        booksFetcher: BooksFetcher
    ) {
        self.service = service
        self.coordinator = coordinator
        self.booksFetcher = booksFetcher
        self.booksFetcher.$booksResult.assign(to: &$booksResult)
        self.booksFetcher.$fetchingError.assign(to: &$fetchingError)
        updateBooks()
    }
    
    func goToDetails(for id: Int) {
        coordinator.coordinate(to: .details(id))
    }
    
    func updateBooks() {
        booksFetcher.updateBooks()
    }
}
