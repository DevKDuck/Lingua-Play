//
//  ViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/24.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    @IBAction func nextButton(_ sender: UIButton) {
        let url = "https://api.chucknorris.io/jokes/random"
        getData(url: url)
    }
    
    func getData(url: String){
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding:URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of:Response.self){ response in
                switch response.result{
                case .success(let data):
                    self.change(str: data.value)
                    
                case .failure(_):
                    print("Alamofire GET ChckNorrisJoke Data Decoding fail")
                }
                
                
            }
                
        
        //MARK: URLSession을 이용하여 ChuckNorrisJoke API에서 GET형식으로 받아오는 로직
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//
//        URLSession.shared.dataTask(with: request){ data, response, error in
//            guard error == nil else{
//                print("Error: error calling GET")
//                return
//            }
//            guard let data = data else{
//                print("Error: Did not recieve data")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//            guard let output = try? JSONDecoder().decode(Response.self, from: data) else{
//                print("Error: JSON Data Parsing failed")
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.jokeLabel.text = output.value
//            }
//            self.change(str: output.value)
//            
//        }.resume()
//
    }
    
    func change(str: String){
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue(Storage().naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(Storage().naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let param = "source=en&target=ko&text=\(str)"
        
        request.httpBody = param.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard error == nil else{
                print("Error: error calling GET")
                return
            }
            guard let data = data else{
                print("Error: Did not recieve data")
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                if let res = response as? HTTPURLResponse, (400 ..< 500) ~= res.statusCode{
                    print(res.statusCode.description)
                }
                
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(PaPago.self,from: data) else{
                print("PaPago JSON Parsing failed")
                return
            }
                
            DispatchQueue.main.async {
                self.jokeLabel.text = output.message.result.translatedText
            }
            
        }.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        jokeLabel.text = "Button Click"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapNextGameButton(_ sender: UIButton) {
        
        let vc = ImageGameViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
}

