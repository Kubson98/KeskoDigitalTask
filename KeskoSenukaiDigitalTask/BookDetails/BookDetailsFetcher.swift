//
//  BookDetailsFetcher.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 09/04/2024.
//

import Foundation
import Services

final class BookDetailsFetcher {
    @Published private(set) var details: BookDetails?
    @Published private(set) var fetchingError: FetchingError? = nil
    private let service: ServiceManaging
    private let bookId: Int
    
    init(service: ServiceManaging, bookId: Int) {
        self.service = service
        self.bookId = bookId
    }
    
    func fetchBookDetails() {
        service.fetchDetails(for: bookId, completion: { [weak self] (result: Result<Services.BookDetails, APIError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.details = .init(details: response)
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.fetchingError = .failedFetching
                }
            }
        })
    }
}
