//
//  Service.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/09/11.
//

import Foundation

class Service{
    let repository = Repository()
    
    var updateModel = [Model]()
    
    func fetchNews(onCompleted: @escaping ([Model]) -> Void){
        
        repository.fetchNews{ [weak self] entity in
            var modelList = [Model]()
            
            for model in entity.articles{
                var m = Model(newsTitle: "", newsDescription: "", newsAuthor: "", newsimageUrl: "", newsContent: "")
                if let title = model.title{
                    m.newsTitle = title
                }else{
                    m.newsTitle = "Have no Title"
                }
                
                if let description = model.description{
                    m.newsDescription = description
                }else{
                    m.newsDescription = "Have no Description"
                }
                
                if let author = model.author{
                    m.newsAuthor = author
                }else{
                    m.newsAuthor = "Have no author"
                }
                if let urlToImage = model.urlToImage{
                    m.newsimageUrl = urlToImage
                }else{
                    m.newsimageUrl = "Have no urlToImage"
                }
                
                if let content = model.content{
                    m.newsContent = content
                }else{
                    m.newsContent = "Have no Content"
                }
                modelList.append(m)
            }
            
            self?.updateModel = modelList
            
            onCompleted(modelList)
            
        }
    }
}
