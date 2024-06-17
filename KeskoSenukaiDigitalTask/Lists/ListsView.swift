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
            case .some(let errorType):
                InfoView(action: { viewModel.updateLists() }, type: errorType)
            case .none:
                ListsScrollView(
                    lists: viewModel.lists,
                    onTapped: viewModel.goToList(for:),
                    onRefresh: viewModel.updateLists
                )
            }
        }
    }
}

fileprivate struct ListsScrollView: View {
    let lists: [List]
    let onTapped: (Int) -> ()
    let onRefresh: () -> ()
    
    var body: some View {
        ScrollView {
            ForEach(lists, id: \.id) { list in
                VStack {
                    LargeCell(list: list) {
                        onTapped(list.id)
                    }
                }
            }
        }.refreshable {
            onRefresh()
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
                ShowAllButton(onTapped: onTapped)
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

fileprivate struct ShowAllButton: View {
    let onTapped: (() -> Void)
    
    var body: some View {
        Button(action: { onTapped() }, label: {
            VStack {
                Text("SHOW ALL")
                    .tint(.white)
                    .padding(4)
            }
            .background(Color(UIColor(red: 0.17, green: 0.20, blue: 0.21, alpha: 1.00)))
            .cornerRadius(8)
            .padding(.horizontal, 16)
        })
    }
}

fileprivate struct HomeBookPreview: View {
    let preview: Book
    var body: some View {
        VStack(spacing: 10) {
            HomeBookPreviewImage(imgURL: preview.imgURL)
            Text(preview.title).frame(width: 160).dynamicTypeSize(.small)
        }
        .padding(16)
        .background(Color(UIColor(red: 0.28, green: 0.33, blue: 0.37, alpha: 1.00)))
        .frame(height: 160)
        .cornerRadius(8)
        .multilineTextAlignment(.leading)
    }
}

fileprivate struct HomeBookPreviewImage: View {
    let imgURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imgURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 80, height: 120)
                    .aspectRatio(contentMode: .fit)
                    .fixedSize(horizontal: false, vertical: true)
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
