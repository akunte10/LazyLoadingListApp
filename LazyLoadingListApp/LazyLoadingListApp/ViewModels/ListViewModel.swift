//
//  ListViewModel.swift
//  LazyLoadingListApp
//
//  Created by Ajay Kunte on 05/03/25.
//

import Combine
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var items: [ListItem] = []
    private let service = ListService()
    private var currentPage = 1
    private let itemsPerPage = 10
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMoreItems() {
        service.fetchItems(page: currentPage, limit: itemsPerPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] newItems in
                self?.items.append(contentsOf: newItems)
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
