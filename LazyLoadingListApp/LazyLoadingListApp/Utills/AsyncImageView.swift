//
//  AsyncImageView.swift
//  LazyLoadingListApp
//
//  Created by Ajay Kunte on 05/03/25.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    
    init(url: URL?) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
        } else {
            ProgressView()
                .frame(width: 50, height: 50)
                .onAppear { loader.load() }
        }
    }
}
