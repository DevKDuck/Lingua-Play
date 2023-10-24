//
//  News.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/24.
//

import Foundation

struct NewsServiceKey{
    let serviceKey: String = "75b34d78-49c3-4850-b7d8-a68f3e0fb1a3"
}


struct NewsAPI: Codable{
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Codable{
    let source: ArticlesSource
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
}
struct ArticlesSource: Codable{
    let id: String
    let name: String
}
