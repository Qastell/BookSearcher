//
//  ImageLoader.swift
//  BookSearcher
//
//  Created by Кирилл Романенко on 07.02.2024.
//

import UIKit

final class ImageLoader {
    private var cache = NSCache<NSURL, UIImage>()

    init(cacheCountLimit: Int) {
        cache.countLimit = cacheCountLimit
    }
    
    func downloadImage(url: URL) async throws -> UIImage {
        if let cachedImage = lookupCache(for: url) {
            return cachedImage
        }

        let data = try await downloadImageData(url: url)
        guard let image = UIImage(data: data) else {
            throw BSError.imageLoadingError
        }

        updateCache(image: image, for: url)
        return image
    }
}

private extension ImageLoader {
    func downloadImageData(url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }

    func lookupCache(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func updateCache(image: UIImage, for url: URL) {
        if cache.object(forKey: url as NSURL) == nil {
            cache.setObject(image, forKey: url as NSURL)
        }
    }
}
