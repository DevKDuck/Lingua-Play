//
//  ImageGameViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/25.
//

import UIKit
import Alamofire

class ImageGameViewController: UIViewController{
    
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let randomLabel: UILabel = {
        let label = UILabel()
        label.text = "RANDOM LABEL"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음 단어", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapRandomButton(_:)), for: .touchUpInside)
        return button
        
    }()
    
    @objc func tapRandomButton(_ sender: UIButton){
        let url = "https://random-words5.p.rapidapi.com/getRandom"
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": RapidKey().rapidAPIKey,
            "X-RapidAPI-Host": RapidKey().rapidAPIHost
        ]

        
        AF.request(url,
                   method: .get,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .response{ r in
            switch r.result{
            case .success(let data):
                if let data = data{
                    if let str = String(data: data, encoding: .utf8){
                        print(str)
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
      
    }
    
    
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var fixImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 갱신 버튼", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tapButton(_ sender: UIButton){
        guard let text = textField.text else{
            return
        }
        getImage(str: text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        setConstraints()
        hideKeyBoard()
        
        
    }
    
    func getImage(str: String){
        
        let encodedQuery = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://openapi.naver.com/v1/search/image?query=\(encodedQuery)"
        
        
        guard let url = URL(string:urlString) else {
            print("String -> URL fail")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(Storage().naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(Storage().naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
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
            
            guard let d = try? JSONDecoder().decode(NaverImage.self, from: data) else{
                return
            }
            
            let imagestr = d.items[0].link
            if let imageURL = URL(string: imagestr){
                downloadImage(from: imageURL)
            }
            
            func downloadImage(from url: URL){
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error while downloading image: \(error?.localizedDescription ?? "")")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self.imageView.image = image
                            print(d.items.count)
                        } else {
                            print("Error: Invalid image data")
                        }
                    }
                }.resume()
            }
            
        }.resume()
        
    }
    
    private func setConstraints(){
        self.view.addSubview(imageView)
        self.view.addSubview(textField)
        self.view.addSubview(fixImageButton)
        self.view.addSubview(randomLabel)
        self.view.addSubview(randomButton)

        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        randomLabel.translatesAutoresizingMaskIntoConstraints = false
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        fixImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            //            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            
            
            
            
            fixImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            fixImageButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            fixImageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            fixImageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            fixImageButton.heightAnchor.constraint(equalToConstant: 44),
            
            
            randomLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            randomLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            randomLabel.heightAnchor.constraint(equalToConstant: 44),
            randomLabel.topAnchor.constraint(equalTo: fixImageButton.bottomAnchor, constant: 10),
            
            
            randomButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            randomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            randomButton.heightAnchor.constraint(equalToConstant: 44),
            randomButton.topAnchor.constraint(equalTo: randomLabel.bottomAnchor, constant: 10),
            
        ])
    }
}

extension UIViewController{
    func hideKeyBoard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
