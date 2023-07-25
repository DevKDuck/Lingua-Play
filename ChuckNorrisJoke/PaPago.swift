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
