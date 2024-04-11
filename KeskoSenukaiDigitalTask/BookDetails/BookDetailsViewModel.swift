//
//  BookDetailsViewModel.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 07/04/2024.
//

import Foundation
import Services

class BookDetailsViewModel: ObservableObject {
    @Published private(set) var details: BookDetails?
    @Published private(set) var fetchingError: FetchingError? = nil
    private let service: ServiceManaging
    private let bookDetailsFetcher: BookDetailsFetcher
    
    init(service: ServiceManaging, bookDetailsFetcher: BookDetailsFetcher) {
        self.service = service
        self.bookDetailsFetcher = bookDetailsFetcher
        self.bookDetailsFetcher.$details.assign(to: &$details)
        self.bookDetailsFetcher.$fetchingError.assign(to: &$fetchingError)
        fetchBookDetails()
    }
    
    func fetchBookDetails() {
        bookDetailsFetcher.fetchBookDetails()
    }
}
