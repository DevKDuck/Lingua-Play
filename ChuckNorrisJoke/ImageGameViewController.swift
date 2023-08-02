//
//  ImageGameViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/25.
//

import UIKit
import Alamofire

class ImageGameViewController: UIViewController{
    
    var answer:String?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let randomLabel1: UILabel = {
        let label = UILabel()
        label.text = "RANDOM LABEL1"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let randomLabel2: UILabel = {
        let label = UILabel()
        label.text = "RANDOM LABEL2"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let randomLabel3: UILabel = {
        let label = UILabel()
        label.text = "RANDOM LABEL3"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let answerMeanLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        
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
        fetchWords()
    }
    
    func fetchWords(){
        DispatchQueue.global(qos: .background).async {
            let headers: HTTPHeaders = [
                "X-RapidAPI-Key": RapidKey().rapidAPIKey,
                "X-RapidAPI-Host": RapidKey().rapidAPIHost
            ]
            
            let url = "https://random-words5.p.rapidapi.com/getMultipleRandom?count=3"
            AF.request(url, headers: headers).response { response in
                switch response.result{
                case .success(let data):
                    if let data = data {
                        if var str = String(data: data, encoding: .utf8){
                            str = str.trimmingCharacters(in: ["["])
                            str = str.trimmingCharacters(in: ["]"])
                            
                            str = String(str.filter { $0 != "\"" })
                            
                            let strArray = str.components(separatedBy: ",")
                            let randomNumArray = [0,1,2]
                            guard let randomNum = randomNumArray.randomElement()else{
                                return
                            }
                            self.answer = strArray[randomNum]
                            
                            DispatchQueue.main.async {
                                self.randomLabel1.text = strArray[0]
                                self.randomLabel2.text = strArray[1]
                                self.randomLabel3.text = strArray[2]
                            }
                            self.translationFromEnglishToKorean(str: strArray[randomNum])
                            self.getImage(str: strArray[randomNum])
                            
                        }
                    }
                    
                case .failure(let error):
                    print("Err: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func translationFromEnglishToKorean(str: String){
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        let param: Parameters = ["source" : "en",
                                 "target" : "ko",
                                 "text" : str]
        
        
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
                    self.answerMeanLabel.text = data.message.result.translatedText
                }
            case.failure(_):
                print("Papago API POST failed")
            }
            
        }
        
        
    }
    
    // MARK: Naver 사전 API를 이용해서 단어 뜻 받아오는 로직
    //    func getWordMeans(query: String){
    //        DispatchQueue.global(qos: .background).async {
    //
    //            let urlString = "https://openapi.naver.com/v1/search/encyc.json?query=\(query)"
    //            guard let url = URL(string:urlString) else {
    //                print("String -> URL fail")
    //                return
    //            }
    //
    //            var request = URLRequest(url: url)
    //            request.httpMethod = "GET"
    //            request.addValue(Storage().naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
    //            request.addValue(Storage().naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
    //
    //
    //            URLSession.shared.dataTask(with: request){ data, response, error in
    //                guard error == nil else{
    //                    print("Error: error calling GET")
    //                    return
    //                }
    //                guard let data = data else{
    //                    print("Error: Did not recieve data")
    //                    return
    //                }
    //
    //
    //                guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
    //                    if let res = response as? HTTPURLResponse, (400 ..< 500) ~= res.statusCode{
    //                        print(res.statusCode.description)
    //                    }
    //
    //                    print("Error: HTTP request failed")
    //                    return
    //                }
    //                guard let mean = try? JSONDecoder().decode(NaverDic.self, from: data) else{
    //                    return
    //                }
    //                if let firstItem = mean.items.first{
    //                    DispatchQueue.main.async {
    //                        self.answerMeanLabel.text = firstItem.description
    //                    }
    //                }
    //
    //            }.resume()
    //        }
    //    }
    
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("정답 확인 하기", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(confirmTapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func confirmTapButton(_ sender: UIButton){
        guard let text = textField.text else{
            return
        }
        
        if text.isEmpty{
            pushAlert(title: "빈칸입니다", message: "정답을 적어주세요")
        }
        else{
            if text == answer{
                pushAlert(title: "정답입니다👏", message: "다음 버튼을 눌러주세요")
            }
            else{
                pushAlert(title:"오답입니다", message: "다시 생각해보세요")
            }
        }
        
        
    }
    
    func pushAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        setConstraints()
        hideKeyBoard()
        
    }
    
    func getImage(str: String){
        let encodedQuery = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://openapi.naver.com/v1/search/image?query=\(encodedQuery)"
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id" : Storage().naverClientID, "X-Naver-Client-Secret" : Storage().naverClientSecret]
        
        
        AF.request(url,method: .get,headers: headers)
            .responseDecodable(of: NaverImage.self){ data in
                switch data.result{
                case .success(let images):
                    let imageStr = images.items[0].link
                    if let imageURL = URL(string: imageStr){
                        self.downloadImage(from: imageURL)
                    }
                case .failure(let err):
                    print("Err: \(err.localizedDescription)")
                }
                
            }
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
                } else {
                    print("Error: Invalid image data")
                }
            }
        }.resume()
    }
    
    //MARK: URLSession 이용하여 이미지 받아오기
    //        URLSession.shared.dataTask(with: request){ data, response, error in
    //            guard error == nil else{
    //                print("Error: error calling GET")
    //                return
    //            }
    //            guard let data = data else{
    //                print("Error: Did not recieve data")
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
    //                if let res = response as? HTTPURLResponse, (400 ..< 500) ~= res.statusCode{
    //                    print(res.statusCode.description)
    //                }
    //
    //                print("Error: HTTP request failed")
    //                return
    //            }
    //
    //            guard let imageData = try? JSONDecoder().decode(NaverImage.self, from: data) else{
    //                return
    //            }
    //
    //            let imagestr = imageData.items[0].link
    //            if let imageURL = URL(string: imagestr){
    //                downloadImage(from: imageURL)
    //            }
    //
    //            func downloadImage(from url: URL){
    //
    //                URLSession.shared.dataTask(with: url) { data, response, error in
    //                    guard let data = data, error == nil else {
    //                        print("Error while downloading image: \(error?.localizedDescription ?? "")")
    //                        return
    //                    }
    //
    //                    DispatchQueue.main.async {
    //                        if let image = UIImage(data: data) {
    //                            self.imageView.image = image
    //                            print(imageData.items.count)
    //                        } else {
    //                            print("Error: Invalid image data")
    //                        }
    //                    }
    //                }.resume()
    //            }
    //
    //        }.resume()
    
    
    private func setConstraints(){
        self.view.addSubview(imageView)
        self.view.addSubview(textField)
        self.view.addSubview(confirmButton)
        self.view.addSubview(randomLabel1)
        self.view.addSubview(randomLabel2)
        self.view.addSubview(randomLabel3)
        self.view.addSubview(randomButton)
        self.view.addSubview(answerMeanLabel)
        
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        randomLabel1.translatesAutoresizingMaskIntoConstraints = false
        randomLabel2.translatesAutoresizingMaskIntoConstraints = false
        randomLabel3.translatesAutoresizingMaskIntoConstraints = false
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        answerMeanLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            //            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            //            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            answerMeanLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            answerMeanLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            answerMeanLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            answerMeanLabel.heightAnchor.constraint(equalToConstant: 100),
            answerMeanLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            
            
            
            randomLabel1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            randomLabel1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            randomLabel1.heightAnchor.constraint(equalToConstant: 44),
            randomLabel1.topAnchor.constraint(equalTo: answerMeanLabel.bottomAnchor, constant: 20),
            
            randomLabel2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            randomLabel2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            randomLabel2.heightAnchor.constraint(equalToConstant: 44),
            randomLabel2.topAnchor.constraint(equalTo: randomLabel1.bottomAnchor, constant: 10),
            
            randomLabel3.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            randomLabel3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            randomLabel3.heightAnchor.constraint(equalToConstant: 44),
            randomLabel3.topAnchor.constraint(equalTo: randomLabel2.bottomAnchor, constant: 10),
            
            
            randomButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            randomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            randomButton.heightAnchor.constraint(equalToConstant: 44),
            randomButton.topAnchor.constraint(equalTo: randomLabel3.bottomAnchor, constant: 10),
            
            
            
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 20),
            
            
            confirmButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            
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
