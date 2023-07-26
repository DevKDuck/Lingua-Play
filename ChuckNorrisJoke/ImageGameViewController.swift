//
//  ImageGameViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/25.
//

import UIKit

class ImageGameViewController: UIViewController{
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    
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

            //
            //                let d = try? JSONSerialization.jsonObject(with: data)
            //                print(d)
            //
            //            guard let output = try? JSONDecoder().decode(PaPago.self,from: data) else{
            //                print("PaPago JSON Parsing failed")
            //                return
            //            }
            
        }.resume()
        
        //        사이온 나서스 애쉬 아크샨  세주아니 자르반 리산 아지르
    }
    
    private func setConstraints(){
        self.view.addSubview(imageView)
        self.view.addSubview(textField)
        self.view.addSubview(fixImageButton)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        fixImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 20),
            //            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            //            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            
            
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 20),
            
            
            
            
            fixImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            fixImageButton.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 10),
            fixImageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            fixImageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            fixImageButton.heightAnchor.constraint(equalToConstant: 44)
            
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
