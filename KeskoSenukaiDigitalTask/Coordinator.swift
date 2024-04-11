//
//  Coordinator.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 06/04/2024.
//

import SwiftUI

enum Destination {
    case home
    case books(Int)
    case details(Int)
}

protocol Coordinating {
    var navigationController: UINavigationController { get }
    func start()
    func pop()
    func coordinate(to destination: Destination)
}

final class MainCoordinator: Coordinating {
    var navigationController: UINavigationController
    private let dependencies: Dependencies
    let viewFactory: ViewFactory
    
    init(
        navigationController: UINavigationController,
        dependencies: Dependencies,
        viewFactory: ViewFactory
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.viewFactory = viewFactory
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        coordinate(to: .home)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func coordinate(to destination: Destination) {
        switch destination {
        case .home:
            let vc = UIHostingController(rootView: viewFactory.buildHomeView(coordinator: self))
            navigationController.pushViewController(vc, animated: true)
        case .books(let listId):
            let vc = UIHostingController(rootView: viewFactory.buildBooksView(for: listId, coordinator: self))
            navigationController.pushViewController(vc, animated: true)
        case .details(let bookId):
            let vc = UIHostingController(rootView: viewFactory.buildBookDetailsView(for: bookId, coordinator: self))
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
