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
    let imgURL: String
    let isbn: String?
    let publicationDate: String?
    let author: String
    let description: String
}
