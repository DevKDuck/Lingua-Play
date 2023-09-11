//
//  Repository.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/09/11.
//

import Foundation
import Alamofire


class Repository{
    func fetchNews(onCompleted: @escaping (NewsAPI)-> Void){
        let url =  "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6cadc26e16894316aff6cfde14050ba5"
        
        AF.request(url, method: .get, parameters: nil).validate(statusCode: 200..<300).responseDecodable(of: NewsAPI.self){ response in
            switch response.result{
            case .success(let model):
                onCompleted(model)
            case.failure(let err):
                print("Fetch NewsAPI Data \(err.localizedDescription)")
            }
            
        }
    }
}
