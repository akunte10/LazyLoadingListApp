//
//  ListUIView.swift
//  LazyLoadingListApp
//
//  Created by Ajay Kunte on 05/03/25.
//

import SwiftUI

struct ListUIView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \..id) { item in
                    HStack {
                        AsyncImageView(url: item.imageUrl)
                        Text(item.title)
                            .font(.headline)
                    }
                    .onAppear {
                        if item == viewModel.items.last {
                            viewModel.fetchMoreItems()
                        }
                    }
                }
            }
            .navigationTitle("Lazy List")
            .onAppear {
                viewModel.fetchMoreItems()
            }
        }
    }
}
