//
//  Test.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/31.
//

import Foundation

class 나중에생기는데이터<T>{
    private let task: (@escaping (T)-> Void) -> Void
    init(task: @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    func 나중에오면(_  f:@escaping (T) -> Void){
        task(f)
    }
}

//RxSwift는 비동기적인 작업을 CompletionHandler처럼 클로저를 통해서 전달하는 것이 아닌
//Return값으로 전단하기 위해서 만들어진 유틸리티이다.
