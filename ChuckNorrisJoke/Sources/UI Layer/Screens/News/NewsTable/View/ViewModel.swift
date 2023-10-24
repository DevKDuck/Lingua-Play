//
//  ViewModel.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/09/11.
//

import Foundation
import RxRelay
import RxSwift


class Viewmodel{
    
    let service = Service()
    
    var items = BehaviorRelay<[Model]>(value: [])
    
    func reload(){
        //Model -> ViewModel
        
        service.fetchNews{ [weak self] model in
            guard let self = self else {return}
            
            items.accept(model)
            
        }
    }
}


struct NewsItem{
    var title : String
    var description: String
    var author: String
    var imgUrl: String
    var content: String
}
