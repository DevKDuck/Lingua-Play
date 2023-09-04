//
//  Test.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/31.
//

import Foundation
import UIKit
import RxSwift
import Then


//class 나중에생기는데이터<T>{
//    private let task: (@escaping (T)-> Void) -> Void
//    init(task: @escaping (@escaping (T) -> Void) -> Void) {
//        self.task = task
//    }
//    func 나중에오면(_  f:@escaping (T) -> Void){
//        task(f)
//    }
//}

//RxSwift는 비동기적인 작업을 CompletionHandler처럼 클로저를 통해서 전달하는 것이 아닌
//Return값으로 전단하기 위해서 만들어진 유틸리티이다.

class Test: UIViewController{
    
    let labelA = UILabel().then{
        $0.textColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "TestLabel"
        $0.numberOfLines = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setConstraints()
        onLoad()
    }
    
    func setConstraints(){
        view.addSubview(labelA)
        
        NSLayoutConstraint.activate([
        labelA.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        labelA.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        labelA.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        labelA.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    func onLoad(){
        let obaservable = fetchData()
        
        let disposbale = obaservable
        //            .debug() -> 과정을 볼 수 있음
            .subscribe{ event in
            switch event{
            case let .next(json):
                DispatchQueue.main.async {
                    self.labelA.text = json
                }
            case .completed:
                break
            case .error:
                break
            }
            
        }
//        disposbale.dispose() 필요에 의해 작업을 취소할 때 사용
    }
    
    /*Observable의 생명주기
    1. Create - 이떄는 실행되지 않음
    2. subscribe - 이때 동작 됨
    3. onNext 로 데이터가 전달되다가 // onError 로 에러가 날 수 있음
     ----------끝--------
    4. onCompleted 되다가 끝남 //onError 로 끝날 수 있음
    5. Disposed
    */
    
    func fetchData() -> Observable<String?> {
        return Observable.just("Helloworld")
        /*
         -> 데이터 하나 보내는것은 .just로 보낼 수 있음
         return Observable.create{ emitter in
             emitter.onNext("Hello world")
             emitter.onCompleted()
             return Disposbles.create()
         }
         */
        
        
//        return Observable.create() { emitter in
//            let url = URL(string: "https://api.chucknorris.io/jokes/random")!
//            let task = URLSession.shared.dataTask(with: url){ (data, _, err) in
//                guard err == nil else{
//                    emitter.onError(err!)
//                    return
//                }
//
//                if let dat = data, let json = String(data: dat, encoding: .utf8){
//                    emitter.onNext(json)
//                }
//
//                emitter.onCompleted() // 이때 클로저의 순환참조가 클로저 종료에 의해 종료됨
//            }
//            task.resume()
//            return Disposables.create {
//                task.cancel()
//            }
//        }
        
    }
}
