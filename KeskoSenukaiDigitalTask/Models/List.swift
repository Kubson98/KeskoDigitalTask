//
//  List.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 04/04/2024.
//

struct List: Hashable {
    static func == (lhs: List, rhs: List) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.books == rhs.books
    }
    
    let id: Int
    let title: String
    let books: [Book]
    
    init(id: Int, title: String, books: [Book]) {
        self.id = id
        self.title = title
        self.books = books
    }
}
