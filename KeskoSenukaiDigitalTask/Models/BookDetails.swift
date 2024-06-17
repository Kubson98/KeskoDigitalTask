//
//  BookDetails.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation

public struct BookDetails: Hashable {
    let id: Int
    let listId: Int
    let title: String
    let imgURL: String?
    let isbn: String?
    let publicationDate: String?
    let author: String
    let description: String
    
    init(id: Int, listId: Int, title: String, imgURL: String?, isbn: String?, publicationDate: String?, author: String, description: String) {
        self.id = id
        self.listId = listId
        self.title = title
        self.imgURL = imgURL
        self.isbn = isbn
        self.publicationDate = publicationDate
        self.author = author
        self.description = description
    }
    
    init() {
        self.id = 0
        self.listId = 0
        self.title = "title"
        self.imgURL = nil
        self.isbn = nil
        self.publicationDate = nil
        self.author = "author"
        self.description = "description"
    }
}
