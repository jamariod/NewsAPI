//
//  News.swift
//  NewsAPI
//
//  Created by Jamario Davis on 12/31/20.
//

import Foundation

struct NewEnvelope: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
struct News: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
}

