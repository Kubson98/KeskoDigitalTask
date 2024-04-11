//
//  ListsView.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 04/04/2024.
//

import SwiftUI

struct ListsView: View {
    @ObservedObject var viewModel: ListsViewModel
    var body: some View {
        VStack {
            switch viewModel.fetchingError {
            case .failedFetching:
                InfoView(action: { viewModel.updateLists() }, type: .error)
            case .noData:
                InfoView(action: { viewModel.updateLists() }, type: .noData)
            case .none:
                ScrollView {
                    ForEach(viewModel.lists, id: \.id) { list in
                        VStack {
                            LargeCell(list: list) {
                                viewModel.goToList(for: list.id)
                            }
                        }
                    }
                }.refreshable {
                    viewModel.updateLists()
                }
            }
        }
    }
}

fileprivate struct LargeCell: View {
    let list: List
    let onTapped: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(list.title).font(.title).foregroundStyle(.gray)
                Spacer()
                Button(action: { onTapped() }, label: {
                    VStack {
                        Text("SHOW ALL")
                            .tint(.white)
                            .padding(4)
                    }
                    .background(Color(uiColor: UIColor(red: 0.13, green: 0.12, blue: 0.09, alpha: 1.00)))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                })
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(list.books.prefix(5), id: \.id) { preview in
                        HomeBookPreview(preview: preview)
                    }
                }
            }
        }
    }
}

fileprivate struct HomeBookPreview: View {
    let preview: Book
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: preview.imgURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 80, height: 120)
                        .aspectRatio(contentMode: .fit)
                    Text(preview.title).frame(width: 160).dynamicTypeSize(.small)
                } else if phase.error != nil {
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                } else {
                    ProgressView()
                }
            }
        }
        .padding(16)
        .background(Color(uiColor: UIColor(red: 0.19, green: 0.18, blue: 0.11, alpha: 1.00)))
        .frame(height: 160)
        .cornerRadius(8)
        .multilineTextAlignment(.leading)
    }
}
