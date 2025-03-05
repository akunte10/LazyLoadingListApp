//
//  ListService.swift
//  LazyLoadingListApp
//
//  Created by Ajay Kunte on 05/03/25.
//

import Combine
import Foundation

class ListService {
    func fetchItems(page: Int, limit: Int) -> AnyPublisher<[ListItem], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_limit=\(limit)&_page=\(page)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [ListItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
