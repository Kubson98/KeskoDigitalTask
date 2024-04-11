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
            case .failedFetching:
                InfoView(action: { viewModel.updateBooks() }, type: .error)
            case .noData:
                InfoView(action: { viewModel.updateBooks() }, type: .noData)
            case .none:
                ScrollView {
                    ForEach(viewModel.booksResult, id: \.id) { book in
                        VStack {
                            BookCell(book: book) {
                                viewModel.goToDetails(for: book.id)
                            }
                        }
                    }
                }.refreshable {
                    viewModel.updateBooks()
                }
            }
        }
    }
}

struct BookCell: View {
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
                            AsyncImage(url: URL(string: book.imgURL)) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 120)
                                    .aspectRatio(contentMode: .fit)
                                    .fixedSize(horizontal: false, vertical: true)
                            } placeholder: {
                                ProgressView()
                            }
                            VStack(alignment: .center, spacing: 4) {
                                Text("Title").font(.caption2).foregroundStyle(.gray)
                                Text(book.title).font(.headline)
                                Text("Author").font(.caption2).foregroundStyle(.gray)
                                Text(book.author).font(.headline)
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
            .background(Color(uiColor: UIColor(red: 0.19, green: 0.18, blue: 0.11, alpha: 1.00)))
            .cornerRadius(8)
            .padding()
        }
    }
}
