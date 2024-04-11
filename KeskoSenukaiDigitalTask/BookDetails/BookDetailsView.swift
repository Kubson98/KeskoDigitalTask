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
        case .failedFetching:
            InfoView(action: { viewModel.fetchBookDetails() }, type: .error)
        default:
            if let details = viewModel.details {
                ScrollView {
                    VStack(spacing: 10) {
                        AsyncImage(url: URL(string: details.imgURL)) { image in
                            image
                                .resizable()
                                .frame(width: 240, height: 360)
                                .aspectRatio(contentMode: .fit)
                                .fixedSize(horizontal: false, vertical: true)
                        } placeholder: {
                            ProgressView()
                        }
                        Text("Title").font(.caption2).foregroundStyle(.gray)
                        Text(details.title).font(.headline)
                        Text("Author").font(.caption2).foregroundStyle(.gray)
                        Text(details.author).font(.headline)
                        if let isbn = details.isbn {
                            Text("ISBN").font(.caption2).foregroundStyle(.gray)
                            Text(isbn).font(.headline)
                        }
                        if let date = details.publicationDate {
                            Text("Publication Date").font(.caption2).foregroundStyle(.gray)
                            Text(date).font(.headline)
                        }
                        Text("Description").font(.caption2).foregroundStyle(.gray)
                        Text(details.description).font(.headline).padding(.horizontal, 8)
                    }.padding(10)
                }.refreshable {
                    viewModel.fetchBookDetails()
                }
            } else {
                InfoView(action: { viewModel.fetchBookDetails() }, type: .noData)
            }
        }
    }
}

