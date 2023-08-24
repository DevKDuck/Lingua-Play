//
//  News.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/24.
//

import Foundation

private struct NewsServiceKey{
    let serviceKey: String = "75b34d78-49c3-4850-b7d8-a68f3e0fb1a3"
}

struct News: Codable{
    let response: NewsResponse
}

struct NewsResponse: Codable{
    let header: NewsHeader
    let body: NewsBody
}

struct NewsHeader: Codable{
    let resultCode: String
    let resultMsg: String
}

struct NewsBody: Codable{
    let items: NewsBodyItems
    let numOfRows: String
    let pageNo: String
    let totalCount: String
}

struct NewsBodyItems: Codable{
    let item: [NewsBodyItem]
}

struct NewsBodyItem: Codable{
    let title: String?
    let alternativeTitle: String?
    let creator: String?
    let regDate: String?
    let collectionDb: String?
    let subjectCategory: String?
    let subjectKeyword: String?
    let extent: String?
    let description: String?
    let spatialCoverage: String?
    let temporalCoverage: String?
    let person: String?
    let language: String?
    let sourceTitle: String?
    let referenceIdentifier: String?
    let rights: String?
    let copyrightOthers: String?
    let url: String
    let contributor: String?
}
