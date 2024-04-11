//
//  List+Extensions.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation
import Services

extension List {
    init(list: Services.List) {
        self.init(id: list.id, title: list.title, books: [])
    }
}
