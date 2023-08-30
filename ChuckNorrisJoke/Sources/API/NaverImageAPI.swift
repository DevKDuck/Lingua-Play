//
//  NaverImage.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/26.
//

import Foundation

struct NaverImage: Codable{
    
    var lastBuildDate: String
    // "Wed, 26 Jul 2023 15:59:21 +0900", (Date)
    var total: Int
    var start: Int
    var display: Int
    var items: [Items]
}

struct Items: Codable{
    var title: String
    var link: String
    var thumbnail: String
    var sizeheight: String
    var sizewidth: String
}
