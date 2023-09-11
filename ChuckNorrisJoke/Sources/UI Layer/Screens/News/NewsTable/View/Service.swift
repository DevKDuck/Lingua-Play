//
//  Service.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/09/11.
//

import Foundation

class Service{
    let repository = Repository()
    
    var updateModel = Model(newsTitle: <#T##[String]#>, newsDescription: <#T##[String]#>, newsAuthor: <#T##[String]#>, newsimageUrl: <#T##[String]#>, newscontent: <#T##[String]#>)
    
    
    func fetchNews(onCompleted: @escaping (Model) -> Void){
        
        repository.fetchNews{ [weak self] entity in
//            for model in entity.articles{
//                model.
//            }
            
        }
    }
}
