//
//  Service.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/09/11.
//

import Foundation

class Service{
    let repository = Repository()
    
    var updateModel = Model(newsTitle: [], newsDescription: [], newsAuthor: [], newsimageUrl: [], newscontent: [])
    
    
    func fetchNews(onCompleted: @escaping (Model) -> Void){
        
        repository.fetchNews{ [weak self] entity in
            var titleArray = [String]()
            var descriptionArray = [String]()
            var authorArray = [String]()
            var imgUrlArray = [String]()
            var contentArray = [String]()
            
            for model in entity.articles{
                titleArray.append(model.title)
                descriptionArray.append(model.description)
                authorArray.append(model.author)
                imgUrlArray.append(model.urlToImage)
                contentArray.append(model.content ?? "Have no content")
            }
            
            let model = Model(newsTitle: titleArray, newsDescription: descriptionArray, newsAuthor: authorArray, newsimageUrl: imgUrlArray, newscontent: contentArray)
            
            self?.updateModel = model
            
            onCompleted(model)
            
        }
    }
}
