//
//  ViewModel.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/09/11.
//

import Foundation
import RxRelay


class Viewmodel{
    
    let service = Service()
    
//    var title: [String] = [""]
//    var description: [String] = [""]
//    var author: [String] = [""]
//    var imgUrl: [String] = [""]
//    var content: [String] = [""]
//
    
    var title = BehaviorRelay<String>(value: "")
//    var title = BehaviorRelay<[String]>(value: [])
    var description = BehaviorRelay<[String]>(value: [])
    var author = BehaviorRelay<[String]>(value: [])
    var imgUrl = BehaviorRelay<[String]>(value: [])
    var content = BehaviorRelay<[String]>(value: [])
    
    func reload(){
        //Model -> ViewModel
        
        service.fetchNews{ [weak self] model in
            guard let self = self else {return}
            
            title.accept(model.newsTitle[0])
//            description.accept(model.newsDescription)
//            author.accept(model.newsAuthor)
//            imgUrl.accept(model.newsimageUrl)
//            content.accept(model.newscontent)
            
        }
    }
}
