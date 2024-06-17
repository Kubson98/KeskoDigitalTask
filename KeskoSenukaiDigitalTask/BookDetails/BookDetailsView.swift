//
//  BookDetailsView.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 07/04/2024.
//

import SwiftUI

struct BookDetailsView: View {
    @ObservedObject var viewModel: BookDetailsViewModel
    
    var body: some View {
        switch viewModel.fetchingError {
        case .some(let errorType):
            InfoView(action: { viewModel.fetchBookDetails() }, type: errorType)
        default:
            BookDetailsScrollView(
                details: viewModel.details,
                onRefresh: { viewModel.fetchBookDetails() }
            )
        }
    }
}

fileprivate struct BookDetailsScrollView: View {
    let details: BookDetails
    let onRefresh: () -> ()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                BookDetailsImage(imgURL: details.imgURL)
                BookDetailsTitleSection(title: details.title)
                BookDetailsDescriptionSection(description: details.description)
                if let isbn = details.isbn {
                    BookDetailsISBNSection(isbn: isbn)
                }
                if let date = details.publicationDate {
                    BookDetailsDateSection(date: date)
                }
            }.padding(10)
        }
        .refreshable {
            onRefresh()
        }
    }
}

fileprivate struct BookDetailsImage: View {
    let imgURL: String?
    
    var body: some View {
        AsyncImage(url: URL(string: imgURL ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 240, height: 360)
                    .aspectRatio(contentMode: .fit)
                    .fixedSize(horizontal: false, vertical: true)
            default:
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 240, height: 360)
                    .aspectRatio(contentMode: .fit)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

fileprivate struct BookDetailsTitleSection: View {
    let title: String
    
    var body: some View {
        Text("Title").font(.caption2).foregroundStyle(.gray)
        Text(title).font(.headline)
    }
}

fileprivate struct BookDetailsAuthorSection: View {
    let author: String
    
    var body: some View {
        Text("Author").font(.caption2).foregroundStyle(.gray)
        Text(author).font(.headline)
    }
}

fileprivate struct BookDetailsISBNSection: View {
    let isbn: String
    
    var body: some View {
        Text("ISBN").font(.caption2).foregroundStyle(.gray)
        Text(isbn).font(.headline)
    }
}

fileprivate struct BookDetailsDateSection: View {
    let date: String
    
    var body: some View {
        Text("Publication Date").font(.caption2).foregroundStyle(.gray)
        Text(date).font(.headline)
    }
}

fileprivate struct BookDetailsDescriptionSection: View {
    let description: String
    
    var body: some View {
        Text("Description").font(.caption2).foregroundStyle(.gray)
        Text(description).font(.headline).padding(.horizontal, 8)
    }
}

