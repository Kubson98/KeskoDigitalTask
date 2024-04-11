//
//  BooksFetcher.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 08/04/2024.
//

import Foundation
import Services

final class BooksFetcher {
    @Published private(set) var booksResult: [Book] = []
    @Published private(set) var fetchingError: FetchingError? = nil
    private(set) var books: [Book] = []
    private let service: ServiceManaging
    private let listId: Int
    
    init(service: ServiceManaging, listId: Int) {
        self.service = service
        self.listId = listId
    }
    
    func updateBooks() {
        fetchData()
    }
    
    private func fetchData() {
         let group = DispatchGroup()
         
         group.enter()
         fetchBooksPreview() {
             group.leave()
         }
         
         group.notify(queue: .main) { [weak self] in
             self?.fetchAllDetails()
         }
     }
    
    private func fetchBooksPreview(completion: @escaping () -> Void) {
        service.fetchData(for: .books, completion: { [weak self] (result: Result<[Services.Book], APIError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.books = response
                        .filter { $0.listId == self?.listId }
                        .map { book in
                            return Book.init(book: book)
                        }
                    if response.isEmpty {
                        self?.fetchingError = .noData
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.fetchingError = .failedFetching
                }
            }
            completion()
        })
    }
    
    private func fetchAllDetails() {
        let semaphore = DispatchSemaphore(value: 1)
        booksResult.removeAll()
        books.forEach { [weak self] book in
            semaphore.wait()
            self?.fetchBookDetails(for: book.id, completion: {
                semaphore.signal()
            })
        }
    }
    
    private func fetchBookDetails(for id: Int, completion: @escaping () -> Void) {
        service.fetchDetails(for: id, completion: { [weak self] (result: Result<Services.BookDetails, APIError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.booksResult.append(
                        .init(book: response)
                    )
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.fetchingError = .failedFetching
                }
            }
            completion()
        })
    }
}
