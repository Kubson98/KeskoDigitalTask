//
//  BooksView.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 07/04/2024.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var viewModel: BooksViewModel
    
    var body: some View {
        VStack {
            switch viewModel.fetchingError {
            case .some(let errorType):
                InfoView(action: { viewModel.updateBooks() }, type: errorType)
            case .none:
                BooksScrollView(
                    books: viewModel.booksResult,
                    onTapped: viewModel.goToDetails(for:),
                    onRefresh: viewModel.updateBooks
                )
            }
        }
    }
}

fileprivate struct BooksScrollView: View {
    let books: [Book]
    let onTapped: ((Int) -> Void)
    let onRefresh: () -> ()
    
    var body: some View {
        ScrollView {
            ForEach(books, id: \.id) { book in
                VStack {
                    BookCell(book: book) {
                        onTapped(book.id)
                    }
                }
            }
        }.refreshable {
            onRefresh()
        }
    }
}

fileprivate struct BookCell: View {
    let book: Book
    let onTapped: (() -> Void)
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            HStack {
                HStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            BooksViewImage(imgURL: book.imgURL)
                            VStack(alignment: .center, spacing: 4) {
                                BooksViewTitleSection(title: book.title)
                                BooksViewAuthorSection(author: book.author)
                            }
                            .frame(width: 160)
                            .padding(10)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .foregroundColor(Color.white)
            }
            .background(Color(uiColor: UIColor(red: 0.28, green: 0.33, blue: 0.37, alpha: 1.00)))
            .cornerRadius(8)
            .padding()
        }
    }
}

fileprivate struct BooksViewImage: View {
    let imgURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imgURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 80, height: 120)
                    .aspectRatio(contentMode: .fit)
                    .fixedSize(horizontal: false, vertical: true)
            default:
                Image(systemName: "book")
                    .resizable()
                    .frame(width: 80, height: 120)
                    .aspectRatio(contentMode: .fit)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

fileprivate struct BooksViewTitleSection: View {
    let title: String
    
    var body: some View {
        Text("Title").font(.caption2).foregroundStyle(.gray)
        Text(title).font(.headline)
    }
}

fileprivate struct BooksViewAuthorSection: View {
    let author: String
    
    var body: some View {
        Text("Author").font(.caption2).foregroundStyle(.gray)
        Text(author).font(.headline)
    }
}
