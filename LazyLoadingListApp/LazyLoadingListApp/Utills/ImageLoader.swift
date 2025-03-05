//
//  ImageLoader.swift
//  LazyLoadingListApp
//
//  Created by Ajay Kunte on 05/03/25.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var url: URL?
    private static let cache = NSCache<NSURL, UIImage>()
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() {
        guard let url = url else { return }
        
        if let cachedImage = ImageLoader.cache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageLoader.cache.setObject(uiImage, forKey: url as NSURL)
                    self.image = uiImage
                }
            }
        }.resume()
    }
}
