//
//  LogInViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/03.
//

import UIKit
import Alamofire

class NewsViewController: UIViewController{
    
    func fetchData(serviceKey: String = NewsServiceKey().serviceKey, numberOfRows: Int, pageNo: Int){
        let url = "http://api.kcisa.kr/openapi/service/rest/meta4/getKCPG0504?serviceKey=\(serviceKey)&numOfRows=\(numberOfRows)&pageNo=\(pageNo)"
        
        let headers: HTTPHeaders = ["accept" : "application/json"]
        AF.request(url, method: .get, parameters: nil, headers: headers).validate(statusCode: 200..<300).responseDecodable(of: News.self){ response in
            switch response.result{
            case.success(let d):
                print(d)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
   
    let festivalNewsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
        label.text = "Festival News"
        return label
    }()
    
//    let view1 : UIView = {
//       let view = UIView()
//        view.bounds = CGRect(x: 200, y: 200, width: 150, height: 150)
//        view.backgroundColor = .blue
//        return view
//    }()
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(numberOfRows: 10, pageNo: 1)
        
        
        
        view.backgroundColor = .white
        setConstraintsLayout()
        
    }
    
    func setConstraintsLayout(){
        view.addSubview(festivalNewsTitleLabel)
        
        
    }
    
}
