//
//  NaverDictionaryAPI.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/30.
//

import Foundation

struct NaverDic: Codable{
    
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [NaverDicItems]
}

struct NaverDicItems: Codable{
    let title: String
    let link: String
    let description: String
    let thumbnail: String
}
