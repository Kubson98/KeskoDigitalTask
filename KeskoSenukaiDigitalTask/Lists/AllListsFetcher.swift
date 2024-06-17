//
//  AllListsFetcher.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 08/04/2024.
//

import Foundation
import Services

final class AllListsFetcher {
    @Published private(set) var listPreviews: [List] = []
    @Published private(set) var fetchingError: ErrorType? = nil
    private var lists: [List] = []
    private var books: [Book] = []
    private let service: ServiceManaging

    init(service: ServiceManaging) {
        self.service = service
    }
    
    func updateLists() {
        listPreviews.removeAll()
        fetchData { [weak self] in
            self?.lists.forEach { [weak self] list in
                self?.listPreviews.append(
                    .init(
                        id: list.id,
                        title: list.title,
                        books: self?.books.filter { book in
                            book.listId == list.id
                        } ?? []
                    )
                )
            }
        }
    }
    
    private func fetchData(completion: @escaping () -> Void) {
         let group = DispatchGroup()
         
         group.enter()
         fetchLists {
             group.leave()
         }
         
         group.enter()
         fetchBooksPreview {
             group.leave()
         }
         
         group.notify(queue: .main) {
             completion()
         }
     }
    
    private func fetchLists(completion: @escaping () -> Void) {
        service.fetchData(for: .lists, completion: { [weak self] (result: Result<[Services.List], APIError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.lists = response.map { list in
                        return List(list: list)
                    }
                    completion()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.fetchingError = .error
                }
            }
        })
    }
    
    private func fetchBooksPreview(completion: @escaping () -> Void) {
        service.fetchData(for: .books, completion: { [weak self] (result: Result<[Services.Book], APIError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    self?.books = response.map { book in
                        return Book(book: book)
                    }
                    self?.fetchingError = response.isEmpty ? .noData : nil
                    completion()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.fetchingError = .error
                }
            }
        })
    }
}
