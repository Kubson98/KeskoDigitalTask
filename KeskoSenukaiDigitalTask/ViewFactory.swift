//
//  ViewFactory.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 09/04/2024.
//

import SwiftUI

final class ViewFactory {
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @ViewBuilder func buildHomeView(coordinator: Coordinating) -> some View {
        let viewModel = ListsViewModel(
            service: dependencies.manager,
            coordinator: coordinator,
            listsFetcher: .init(service: dependencies.manager)
        )
        ListsView(viewModel: viewModel)
    }
    
    @ViewBuilder func buildBooksView(for listId: Int, coordinator: Coordinating) -> some View {
        let viewModel = BooksViewModel(
            service: dependencies.manager,
            coordinator: coordinator,
            booksFetcher: .init(service: dependencies.manager, listId: listId)
        )
        BooksView(viewModel: viewModel)
    }
    
    @ViewBuilder func buildBookDetailsView(for bookId: Int, coordinator: Coordinating) -> some View {
        let viewModel = BookDetailsViewModel(
            service: dependencies.manager,
            bookDetailsFetcher: .init(service: dependencies.manager, bookId: bookId)
        )
        BookDetailsView(viewModel: viewModel)
    }
}
