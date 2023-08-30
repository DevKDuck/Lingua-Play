//
//  ImageGameViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/25.
//

import UIKit
import Alamofire
import Lottie

class ImageGameViewController: UIViewController{
    
    var answer:String?
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let guesisngWordsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Guessing Words"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setChoiceStackview(label1: UILabel, label2: UILabel, label3: UILabel) -> UIStackView{
        
        let uiview = UIView()
        uiview.backgroundColor = .black
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.heightAnchor.constraint(equalToConstant: 1).isActive = true
        uiview.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
        
        let uiview2 = UIView()
        uiview2.backgroundColor = .black
        uiview2.translatesAutoresizingMaskIntoConstraints = false
        uiview2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        uiview2.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7).isActive = true
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 2
        stackview.layoutMargins = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        stackview.addArrangedSubview(label1)
        stackview.addArrangedSubview(uiview)
        stackview.addArrangedSubview(label2)
        stackview.addArrangedSubview(uiview2)
        stackview.addArrangedSubview(label3)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }
    
    
    let randomLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    let randomLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    let randomLabel3: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    let answerMeanLabel: UILabel = {
        let label = UILabel()
        label.text = "Play Button Click plz"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 17)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var randomButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(hexCode: "331D2C")
        button.layer.cornerRadius = 30
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapRandomButton(_:)), for: .touchUpInside)
        return button
        
    }()
    
    private var correctAnimationView: LottieAnimationView = .init(name: "correctAnimation.json")
    private var incorrectAnimationView: LottieAnimationView = .init(name: "incorrectAnimation.json")
    
    var startTime : Date?
    var addTime: TimeInterval = 0.0
    
    
    @objc func handleAppBackground(){
        if let startTime = startTime{
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(startTime)
            
            addTime = elapsedTime //Play 후 백그라운드로 이동할 경우 멈추고 Date 를 addTiem에 저장
        }
    }
    
    @objc func tapRandomButton(_ sender: UIButton){
        switch sender.titleLabel?.text{
            
        case "Play":
            fetchWords()
            sender.setTitle("Solving a problem", for: .normal)
            startTime = Date()
            
        case "Next Word":
            fetchWords()
            sender.setTitle("Solving a problem", for: .normal)
            
        case "Solving a problem":
            let alert = UIAlertController(title: "정답을 맞추세요", message: "정확히 작성해 보세요.", preferredStyle: .alert)

            alert.addTextField{ textField in
                textField.placeholder = " Let`s get it 🤙"
            }
            
            let cancle = UIAlertAction(title: "닫기", style: .cancel)
            let confirm = UIAlertAction(title: "확인", style: .default){ [weak self] _ in
                guard let self = self else {return}
                
                if let textField = alert.textFields?.first, let userInput = textField.text{
                    if self.answer == userInput{
                        playAnimation(animationName: correctAnimationView)
                        updateNumbersOfPlays()
                        fetchWords()
                    }else{
                        playAnimation(animationName: incorrectAnimationView)
                    }
                }
            }
            
            alert.addAction(cancle)
            alert.addAction(confirm)

            present(alert, animated: true)
            
        case .none:
            print("버튼라벨이 nil일경우")
        case .some(let label):
            print("버튼라벨은 \(label)입니다.")
        }
    }
    
    func updateNumbersOfPlays(){
        let saveNum = UserDefaults.standard.value(forKey: "ImageGamePlays") ?? 0
        UserDefaults.standard.set(saveNum as! Int + 1, forKey: "ImageGamePlays")
        //누적횟수 저장
        
        let playCount = UserDefaults.standard.value(forKey: "playCount") ?? 0
        UserDefaults.standard.set(playCount as! Int + 1, forKey: "playCount")
        print(playCount)
        //현재 횟수 저장
    }
    
    func updateTime(with timeInterval: TimeInterval){
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((timeInterval * 100).truncatingRemainder(dividingBy: 100))
        
        
        let saveMinutes = UserDefaults.standard.value(forKey: "IGminutes") ?? 0
        let saveSeconds = UserDefaults.standard.value(forKey: "IGseconds") ?? 0
        let saveMilliseconds = UserDefaults.standard.value(forKey: "IGmilliseconds") ?? 0
        
        let playMinutes = UserDefaults.standard.value(forKey: "playMinutes") ?? 0
        let playSeconds = UserDefaults.standard.value(forKey: "playSeconds") ?? 0
        let playMilliseconds = UserDefaults.standard.value(forKey: "playMilliseconds") ?? 0

        
        UserDefaults.standard.set(saveMinutes as! Int + minutes, forKey: "IGminutes")
        UserDefaults.standard.set(saveSeconds as! Int + seconds, forKey: "IGseconds")
        UserDefaults.standard.set(saveMilliseconds as! Int + milliseconds, forKey: "IGmilliseconds")
        
        UserDefaults.standard.set(playMinutes as! Int + minutes, forKey: "playMinutes")
        UserDefaults.standard.set(playSeconds as! Int + seconds, forKey: "playSeconds")
        UserDefaults.standard.set(playMilliseconds as! Int + milliseconds, forKey: "playMilliseconds")
        
        
    }
    
    
    func playAnimation(animationName animationView: LottieAnimationView){
        self.view.addSubview(animationView)
        
        animationView.isHidden = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            animationView.isHidden = true
        }
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animationView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            animationView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8)
        ])
    }
    
    func fetchWords(){
        DispatchQueue.global(qos: .background).async {
//            let headers: HTTPHeaders = [
//                "X-RapidAPI-Key": RapidKey().rapidAPIKey,
//                "X-RapidAPI-Host": RapidKey().rapidAPIHost
//            ]
//
//            let url = "https://random-words5.p.rapidapi.com/getMultipleRandom?count=3"
//            AF.request(url, headers: headers).response { response in
//                switch response.result{
//                case .success(let data):
//                    if let data = data {
//                        if var str = String(data: data, encoding: .utf8){
//                            str = str.trimmingCharacters(in: ["["])
//                            str = str.trimmingCharacters(in: ["]"])
//
//                            str = String(str.filter { $0 != "\"" })
//
//                            let strArray = str.components(separatedBy: ",")
            
                            let randomNumArray = [0,1,2]
            let strArray = ["Faker", "Chovy", "Showmaker"]
                            guard let randomNum = randomNumArray.randomElement()else{
                                return
                            }
                            self.answer = strArray[randomNum]
                            
                            DispatchQueue.main.async {
                                //MARK: 한달 사용량 초과 issue....
                                self.randomLabel1.text = "⓵ \(strArray[0])"
                                self.randomLabel2.text = "⓶ \(strArray[1])"
                                self.randomLabel3.text = "⓷ \(strArray[2])"
                            }
            self.translationFromEnglishToKorean(str: strArray[randomNum])
            self.getImage(str: strArray[randomNum])
                            
//                        }
//                    }
//
//                case .failure(let error):
//                    print("Err: \(error.localizedDescription)")
//                }
//            }
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
                    self.answerMeanLabel.text = "해석: \(data.message.result.translatedText)"
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
    
    let choiceBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DBC4F0")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func pushAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        let rightBarButton = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(tapEndButton))
        navigationItem.rightBarButtonItem = rightBarButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    
    @objc func tapEndButton(){
        if let startTime = startTime{
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(startTime)
            
            updateTime(with: elapsedTime + addTime)
        }
        let nextVC = ResultViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 216, green: 217, blue: 218, alpha: 1)
        setConstraints()
        hideKeyBoard()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)   
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
        view.addSubview(guesisngWordsTitleLabel)
        view.addSubview(imageView)
        
        let stackview = setChoiceStackview(label1: randomLabel1, label2: randomLabel2, label3: randomLabel3)
        view.addSubview(randomButton)
        view.addSubview(answerMeanLabel)
        view.addSubview(choiceBGView)
        choiceBGView.addSubview(stackview)
        
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        randomLabel1.translatesAutoresizingMaskIntoConstraints = false
        randomLabel2.translatesAutoresizingMaskIntoConstraints = false
        randomLabel3.translatesAutoresizingMaskIntoConstraints = false
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        answerMeanLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: choiceBGView.bottomAnchor, constant:
                                            view.bounds.height / 50),
            
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height / 4),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            
            
            guesisngWordsTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            guesisngWordsTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            answerMeanLabel.topAnchor.constraint(equalTo: guesisngWordsTitleLabel.bottomAnchor, constant: 10),
            answerMeanLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            answerMeanLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            answerMeanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            choiceBGView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            choiceBGView.topAnchor.constraint(equalTo: answerMeanLabel.bottomAnchor, constant: view.bounds.height / 50),
            choiceBGView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            choiceBGView.heightAnchor.constraint(equalToConstant: view.bounds.height / 4),
            
            stackview.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackview.topAnchor.constraint(equalTo: choiceBGView.topAnchor),
            stackview.bottomAnchor.constraint(equalTo: choiceBGView.bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: choiceBGView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: choiceBGView.trailingAnchor),
            
            
            
            
            
//            randomLabel1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            randomLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            randomLabel1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            randomLabel1.heightAnchor.constraint(equalToConstant: 44),
//            randomLabel1.topAnchor.constraint(equalTo: answerMeanLabel.bottomAnchor, constant: 20),
//
//            randomLabel2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            randomLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            randomLabel2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            randomLabel2.heightAnchor.constraint(equalToConstant: 44),
//            randomLabel2.topAnchor.constraint(equalTo: randomLabel1.bottomAnchor, constant: 10),
//
//            randomLabel3.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            randomLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            randomLabel3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            randomLabel3.heightAnchor.constraint(equalToConstant: 44),
//            randomLabel3.topAnchor.constraint(equalTo: randomLabel2.bottomAnchor, constant: 10),
            
            randomButton.heightAnchor.constraint(equalToConstant: ((view.bounds.width / 7) * 3) / 2),
            randomButton.widthAnchor.constraint(equalToConstant: (view.bounds.width / 6) * 4),
            randomButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
            
//            randomButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            randomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            randomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            randomButton.heightAnchor.constraint(equalToConstant: 44),
//            randomButton.topAnchor.constraint(equalTo: randomLabel3.bottomAnchor, constant: 10),
//
//
//
//            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            textField.heightAnchor.constraint(equalToConstant: 44),
//            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            textField.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 20),
//
//
//            confirmButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            confirmButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
//            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
//
//            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            
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

//extension UIColor{
//    func withAlpha(_ alpha: CGFloat) -> UIColor{
//        return self.withAlphaComponent(alpha)
//    }
//}
