//
//  Book.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation

public struct Book: Hashable {
    let id: Int
    let listId: Int
    let author: String
    let title: String
    let imgURL: String
}
