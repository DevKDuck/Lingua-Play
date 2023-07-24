//
//  ViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/24.
//

import UIKit

struct Response: Codable{
    let icon_url : String
    let id : String
    let url : String
    let value : String
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
            
        }.resume()
    
}
override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    jokeLabel.text = "실행잘돼"
    // Do any additional setup after loading the view.
}


}

