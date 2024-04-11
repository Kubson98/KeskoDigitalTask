//
//  Book+Extension.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation
import Services

public extension Book {
    init(book: Services.Book) {
        self.init(
            id: book.id, 
            listId: book.listId,
            author: "",
            title: book.title,
            imgURL: book.imgURL
        )
    }
}

public extension Book {
    init(book: Services.BookDetails) {
        self.init(
            id: book.id,
            listId: book.listId,
            author: book.author,
            title: book.title,
            imgURL: book.imgURL
        )
    }
}
