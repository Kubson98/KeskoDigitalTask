//
//  BookDetails+Extension.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation
import Services

extension BookDetails {
    init(details: Services.BookDetails) {
        self.init(
            id: details.id,
            listId: details.listId,
            title: details.title,
            imgURL: details.imgURL,
            isbn: details.isbn,
            publicationDate: details.publicationDate.formatedDate(),
            author: details.author,
            description: details.description
        )
    }
}
