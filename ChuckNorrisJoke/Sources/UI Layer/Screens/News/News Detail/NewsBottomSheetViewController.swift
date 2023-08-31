//
//  NewsBottomSheetViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/28.
//

import Foundation
import UIKit
import Then
import SnapKit
import Alamofire
import RxSwift


class NewsBottomSheetViewController: UIViewController{
    
    
    
    var descriptionLabel = UILabel().then{
        $0.textColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
    }
    
    var contentLabel = UILabel().then{
        $0.textColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
    }
    
    lazy var translateButton = UIButton().then{
        $0.setTitle("Translate", for: .normal)
        $0.addTarget(self, action: #selector(tapTranslateButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    @objc func tapTranslateButton(_ sender: UIButton){
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        let descriptionLabelParam: Parameters = ["source" : "en",
                                                 "target" : "ko",
                                                 "text" : descriptionLabel.text ?? "Not Found Description"]
        let conetntLabelParam: Parameters = ["source" : "en",
                                             "target" : "ko",
                                             "text" : contentLabel.text ?? "Not Found Content"]
        
//                fetchPapago(param: descriptionLabelParam,translateLabelName: self.descriptionLabel)
//                fetchPapago(param: conetntLabelParam, translateLabelName: self.contentLabel)
        
//        downloadJson(descriptionLabelParam){ json in
//            self.descriptionLabel.text = json
//        }
//        downloadJson(conetntLabelParam){ json in
//            self.contentLabel.text = json
//        }
//
//
//
//        func downloadJson(_ param: Parameters, _ completion:((String?) -> Void)?){
//
//            AF.request(url, method: .post,
//                       parameters: param,
//                       encoding: URLEncoding.default,
//                       headers: ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
//                                 "X-Naver-Client-Id" : Storage().naverClientID, "X-Naver-Client-Secret" : Storage().naverClientSecret])
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: PaPago.self){ response in
//                switch response.result{
//                case.success(let data):
//                    DispatchQueue.main.async {
//                        completion?(data.message.result.translatedText)
//                    }
//                case.failure(_):
//                    print("Papago API POST failed")
//                }
//
//            }
//
//        }
        
        testxSwiftJson(descriptionLabelParam)
            .subscribe { event in //나중에 오면은 = subscribe  나중에 온게 event
                switch event{
                case .next(let json):
                    self.descriptionLabel.text = json
                case .completed:
                    break
                case .error(_):
                    break
                }
            }
        
        testxSwiftJson(conetntLabelParam)
            .subscribe { event in //나중에 오면은 = subscribe  나중에 온게 event
                switch event{
                case .next(let json):
                    self.contentLabel.text = json
                case .completed:
                    break
                case .error(_):
                    break
                }
            }
        
        func testxSwiftJson(_ param: Parameters) -> Observable<String?> { //Observable 나중에 생기는 데이터
            return Observable.create(){ f in//만들때는 Create 사용
                AF.request(url, method: .post,
                           parameters: param,
                           encoding: URLEncoding.default,
                           headers: ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
                                     "X-Naver-Client-Id" : Storage().naverClientID, "X-Naver-Client-Secret" : Storage().naverClientSecret])
                .validate(statusCode: 200..<300)
                .responseDecodable(of: PaPago.self){ response in
                    switch response.result{
                    case.success(let data):
                        DispatchQueue.main.async {
                            f.onNext(data.message.result.translatedText)
                        }
                    case.failure(_):
                        print("Papago API POST failed")
                    }
                    
                }
                return Disposables.create()
            }
            
        }
        
        
        
        
//        func fetchPapago(param: Parameters, translateLabelName: UILabel){
//            AF.request(url, method: .post,
//                       parameters: param,
//                       encoding: URLEncoding.default,
//                       headers: ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8",
//                                 "X-Naver-Client-Id" : Storage().naverClientID, "X-Naver-Client-Secret" : Storage().naverClientSecret])
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: PaPago.self){ response in
//                switch response.result{
//                case.success(let data):
//                    DispatchQueue.main.async {
//                        translateLabelName.text = "\(data.message.result.translatedText)"
//                    }
//                case.failure(_):
//                    print("Papago API POST failed")
//                }
//
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(translateButton)
        view.addSubview(descriptionLabel)
        view.addSubview(contentLabel)
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        translateButton.snp.makeConstraints{b in
            b.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
            b.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            b.width.equalTo(view.bounds.width / 5)
            b.height.equalTo(44)
        }
        
        descriptionLabel.snp.makeConstraints{ l in
            l.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            l.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
            l.top.equalTo(translateButton.snp.bottom).offset(10)
        }
        
        contentLabel.snp.makeConstraints{l in
            l.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            l.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
            l.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        
    }
}
