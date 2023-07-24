//
//  ViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/24.
//

import UIKit
import Alamofire

struct Response: Codable{
    let icon_url : String
    let id : String
    let url : String
    let value : String
}

struct PaPago: Codable{
    var message: PaPagoMessage
    
//    enum CodingKey: String, CodingKey{
//        case message
//    }
}

struct PaPagoMessage: Codable{
    var type: String
    var service: String
    var version: String
    var result: PaPagoResult
    
    enum CodingKeys: String, CodingKey{
        case type = "@type"
        case service = "@service"
        case version = "version"
        case result
    }
}

struct PaPagoResult: Codable{
    var translatedText: String
    
//    enum CodingKey: String, CodingKey{
//        case translatedText
//    }
}

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
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
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
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(Response.self, from: data) else{
                print("Error: JSON Data Parsing failed")
                return
            }
            
            DispatchQueue.main.async {
                self.jokeLabel.text = output.value
            }
//            self.change(str: output.value)
            self.change(str: "Hi my name is DevKDuck")
            
        }.resume()
        
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
        request.addValue("NOF8K4RW0LrxN29ZrU71", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("FNnU3OtxYD", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let body = ["source" : "en", "target" : "ko", "text" : str] as Dictionary<String,Any>
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Error: Post to PaPago JSON Data Parsing failed")
            return
        }
        
        request.httpBody = jsonData
        
        print(request.httpBody)
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
            guard let output = try? JSONDecoder().decode(PaPago.self, from: data) else{
                print("Error: JSON Data Parsing failed")
                return
            }
            
            print(output.message.result.translatedText)
//
//            DispatchQueue.main.async {
//                self.jokeLabel.text = output.value
//            }
            
        }.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        jokeLabel.text = "Button Click"
        // Do any additional setup after loading the view.
    }
    
    
}

