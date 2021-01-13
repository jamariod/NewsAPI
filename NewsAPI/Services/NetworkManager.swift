//
//  NetworkManager.swift
//  NewsAPI
//
//  Created by Jamario Davis on 12/31/20.
//

import Foundation

class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    static let shared = NetworkManager()
    private init() {}
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=us&category=business"

    func getNews(completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseURL)&apiKey=\(APIKey.key)"
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let newsEnvelope = try? JSONDecoder().decode(NewEnvelope.self, from: data)
            newsEnvelope == nil ? completion(nil) : completion(newsEnvelope!.articles)
        }.resume()
    }
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
}

