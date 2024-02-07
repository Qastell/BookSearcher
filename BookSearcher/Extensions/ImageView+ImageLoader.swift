//
//  ImageView+ImageLoader.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit.UIImageView

extension UIImageView {
    fileprivate static let imageLoader = ImageLoader(cacheCountLimit: 500)
    
    func setImage(_ string: String?) {
        Task {
            if let string, let imageURL = URL(string: string) {
                let image = try? await Self.imageLoader.downloadImage(url: imageURL)
                Task { @MainActor in
                    self.image = image
                }
            }
        }
    }
}
