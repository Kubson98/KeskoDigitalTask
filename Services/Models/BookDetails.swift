//
//  BookDetails.swift
//  Services
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation

public struct BookDetails: Decodable, Hashable {
    public let id: Int
    public let listId: Int
    public let title: String
    public let imgURL: String
    public let isbn: String?
    public let publicationDate: String
    public let author: String
    public let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case listId = "list_id"
        case title
        case imgURL = "img"
        case isbn
        case publicationDate = "publication_date"
        case author
        case description
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.listId = try container.decode(Int.self, forKey: .listId)
        self.title = try container.decode(String.self, forKey: .title)
        self.imgURL = try container.decode(String.self, forKey: .imgURL)
        self.isbn = try container.decodeIfPresent(String.self, forKey: .isbn)
        self.publicationDate = try container.decode(String.self, forKey: .publicationDate)
        self.author = try container.decode(String.self, forKey: .author)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
