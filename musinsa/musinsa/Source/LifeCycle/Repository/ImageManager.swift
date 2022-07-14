//
//  ImageManager.swift
//  musinsa
//
//  Created by dale on 2022/07/14.
//

import Foundation
import Alamofire
import UIKit.UIImage

final class ImageManager {
    static let shared = ImageManager()

    private let fileManager = FileManager()

    func downLoadImage(from url: URL?, completion: @escaping(Result<UIImage?, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }

        let fileName = url.lastPathComponent

        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            completion(.failure(CacheError.invalidDirectory))
            return
        }

        let directory = cacheDirectory.appendingPathComponent(fileName)

        if fileManager.fileExists(atPath: directory.path) {
            let image = UIImage(contentsOfFile: directory.path)
            completion(.success(image))
            return
        }

        let request = AF.download(url)

        request.response { [weak self] response in
            guard let filePath = response.fileURL, response.error == nil  else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            try? self?.fileManager.copyItem(at: filePath, to: directory)
            let image = UIImage(contentsOfFile: directory.path)
            completion(.success(image))
        }
    }
}
