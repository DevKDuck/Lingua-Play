//
//  PaPago.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/25.
//

import Foundation

struct PaPago: Codable{
    var message: PaPagoMessage
}

struct PaPagoResult: Codable{
    var engineType: String
    var srcLangType: String
    var tarLangType: String
    var translatedText: String
}

struct PaPagoMessage: Codable{
    
    var service: String
    var type: String
    var version: String
    var result: PaPagoResult
    
    enum CodingKeys: String, CodingKey{
        case service = "@service"
        case type = "@type"
        case version = "@version"
        case result
    }
}


struct Storage {
    let naverClientID: String = "NOF8K4RW0LrxN29ZrU71"
    let naverClientSecret: String = "FNnU3OtxYD"
}

struct RapidKey{
    let rapidAPIKey: String = "c7951e6ed2msh07f75879a9d74d8p16e9d5jsn4ab031dd49c5"
    let rapidAPIHost: String = "random-words5.p.rapidapi.com"
}


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


struct PathsurlgetParametersSchema: Codable{
    let type: String
    let schemadefault: String?
    
    enum CodingKeys: String, CodingKey{
        case type
        case schemadefault = "default"
    }
}


