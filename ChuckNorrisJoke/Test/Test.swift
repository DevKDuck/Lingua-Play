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
    
    
    var disposablee: Disposable?
    var disposables: [Disposable] = []
    var disposbag = DisposeBag() // Sugar APi
    
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
//        onLoad()
        testRxSwiftCombine()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //MARK: dispose 데이터를 받거나 하는 도중에 창이 닫히면 중단
        disposablee?.dispose()
        
        disposables.forEach{$0.dispose()} //배열에 존재하는 작업 취소
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
    
    func testRxSwiftCombine(){
        
        //MARK: ZiP을 이용한 Rx
        let jsonObservable = fetchData()
        let helloObservable = Observable.just("Hello World")
        
        let d = Observable.zip(jsonObservable,helloObservable) { $1 + "\n" + $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { json in
                self.labelA.text = json
            })
            .disposed(by: disposbag) //.insert 대신 이어서 가능
        
//        disposables.append(d) //disposable 배열에 추가
//        disposbag.insert(d) //sugar API disposeBag
    }
    
    
    func onLoad(){
        let obaservable = fetchData()
        let disposbale = obaservable
        //            .debug() -> 과정을 볼 수 있음
            //MARK: .map (sugar API)를 이용해서 .count로 변환 operator
            /*
             .map{ json in json?.count ?? 0}
            .map{"\($0)"}
             */
        
        //MARK: .filter operator
//            .filter{cnt in cnt > 0}
        
        //MARK: .observeOn()
            .observeOn(MainScheduler.instance)
        //operationQueue를 래핑 한게 Scheduler임
        //MainScheduler는 한개만있어서 instance를 사용하는 것임
        // DispatchQueue.main.async블록 대신 사용 sugar API : operator
        // 다음줄을 다음의 쓰레드로 사용.observeOn(쓰레드)
        
        
        //MARK: .subscribeOn()
        // .subscribeOn() 시작 스레드를 변경, 위치가 상관없음 어디에 있든
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { json in
//                DispatchQueue.main.async {
                    self.labelA.text = json
//                }
            })
        //MARK: subScribe 단순화
//            .subscribe{ event in
//            switch event{
//            case let .next(json):
//                DispatchQueue.main.async {
//                    self.labelA.text = json
//                }
//            case .completed:
//                break
//            case .error:
//                break
//            }
            
//        }
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
    
    func fetchData() -> Observable<String> {
        
        //MARK: Sugar API
        //MARK: just 이용한 Test
        //        return Observable.just("Helloworld")
        /*
         -> 데이터 하나 보내는것은 .just로 보낼 수 있음
         return Observable.create{ emitter in
             emitter.onNext("Hello world")
             emitter.onCompleted()
             return Disposbles.create()
         }
         */
        
        // return observable.just(["Hello", "World]) -> ["Hello", "World"] 반환
        
        //MARK: from 이용한 Test
//        return Observable.from(["Hello","World"])
        // "Hello", "World" 한번씩 차례로반환
         
        
        
        return Observable.create() { emitter in
            let url = URL(string: "https://api.chucknorris.io/jokes/random")!
            let task = URLSession.shared.dataTask(with: url){ (data, _, err) in
                guard err == nil else{
                    emitter.onError(err!)
                    return
                }

                if let dat = data, let json = String(data: dat, encoding: .utf8){
                    emitter.onNext(json)
                }

                emitter.onCompleted() // 이때 클로저의 순환참조가 클로저 종료에 의해 종료됨
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
        
    }
}
