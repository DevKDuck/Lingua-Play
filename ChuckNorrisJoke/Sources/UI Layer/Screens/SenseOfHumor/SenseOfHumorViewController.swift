//
//  ViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/24.
//

import UIKit
import Alamofire


class SenseOfHumorViewController: UIViewController {
    
    var jokeLabelENG:String = ""
    
    func chuckNorrisJokeGetData(){
        let url = "https://api.chucknorris.io/jokes/random"
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding:URLEncoding.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of:ChuckNorrisJoke.self){ response in
            switch response.result{
            case .success(let data):
                self.jokeLabelENG = data.value
                DispatchQueue.main.async {
                    self.humorContentLabel.text = data.value
                }
                
            case .failure(_):
                print("Alamofire GET ChckNorrisJoke Data Decoding fail")
            }
            
            
        }
        
        
        //MARK: URLSession을 이용하여 ChuckNorrisJoke API에서 GET형식으로 받아오는 로직
        //                var request = URLRequest(url: url)
        //                request.httpMethod = "GET"
        //
        //
        //                URLSession.shared.dataTask(with: request){ data, response, error in
        //                    guard error == nil else{
        //                        print("Error: error calling GET")
        //                        return
        //                    }
        //                    guard let data = data else{
        //                        print("Error: Did not recieve data")
        //                        return
        //                    }
        //                    guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
        //                        print("Error: HTTP request failed")
        //                        return
        //                    }
        //                    guard let output = try? JSONDecoder().decode(Response.self, from: data) else{
        //                        print("Error: JSON Data Parsing failed")
        //                        return
        //                    }
        //
        //                    DispatchQueue.main.async {
        //                        self.jokeLabel.text = output.value
        //                    }
        //                    self.change(str: output.value)
        //
        //                }.resume()
        //
    }
    
    
    //MARK: Papago API URLSession을 이용하여 번역
    //    func change(str: String){
    //        let url = "https://openapi.naver.com/v1/papago/n2mt"
    //
    //
    //        guard let url = URL(string: url) else {
    //            print("Error: cannot create URL")
    //            return
    //        }
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    //        request.addValue(Storage().naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
    //        request.addValue(Storage().naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
    //
    //        let param = "source=en&target=ko&text=\(str)"
    //
    //        request.httpBody = param.data(using: .utf8)
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
    //
    //
    //            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
    //                if let res = response as? HTTPURLResponse, (400 ..< 500) ~= res.statusCode{
    //                    print(res.statusCode.description)
    //                }
    //
    //                print("Error: HTTP request failed")
    //                return
    //            }
    //            guard let output = try? JSONDecoder().decode(PaPago.self,from: data) else{
    //                print("PaPago JSON Parsing failed")
    //                return
    //            }
    //
    //            DispatchQueue.main.async {
    //                self.jokeLabelKOR.text = output.message.result.translatedText
    //            }
    //
    //        }.resume()
    //
    //
    //    }
    
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
                    self.koreanContentLabel.text = data.message.result.translatedText
                }
            case.failure(_):
                print("Papago API POST failed")
            }
            
        }
        
        
    }
    
    let humorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Humor"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humorContentLabel: UILabel = {
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
    
    
    let koreanContentBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F4EB")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let koreanContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Translate Button Click"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 17)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var playButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(hexCode: "331D2C")
        button.layer.cornerRadius = 30
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapNextJokeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    var startTime : Date?
    var addTime: TimeInterval = 0.0
    
    @objc func handleAppBackground(){
        if let startTime = startTime{
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(startTime)
            
            addTime = elapsedTime //Play 후 백그라운드로 이동할 경우 멈추고 Date 를 addTiem에 저장
            
            confirmTime(with: elapsedTime)
            playButton.setTitle("Continue", for: .normal)
        }
    }
    
    
    
    @objc func tapNextJokeButton(_ sender: UIButton) {
        switch sender.titleLabel?.text{
        case "Play":
            chuckNorrisJokeGetData()
            
            //시작 시간 설정
            startTime = Date()
            sender.setTitle("Translate", for: .normal)
            
        case "Translate":
            if let startTime = startTime{
                let currentTime = Date()
                let elapsedTime = currentTime.timeIntervalSince(startTime)
                
                confirmTime(with: elapsedTime + addTime)
                updateTime(with: elapsedTime + addTime)
            }
            
            translationFromEnglishToKorean(str: humorContentLabel.text ?? "")
            updateNumbersOfPlays()
            sender.setTitle("Play", for: .normal)
            
        case "Continue":
            startTime = Date()
            sender.setTitle("Translate", for: .normal)
        case .none:
            print("Button Text is none")
        case .some(_):
            print("Button Text is some")
        }
    }
    
    func confirmTime(with timeInterval: TimeInterval){
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((timeInterval * 100).truncatingRemainder(dividingBy: 100))
        
        print(minutes,seconds,milliseconds)
    }
    
    func updateNumbersOfPlays(){
        let saveNum = UserDefaults.standard.value(forKey: "NumbersOfPlays") ?? 0
        UserDefaults.standard.set(saveNum as! Int + 1, forKey: "NumbersOfPlays")
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
        
        
        let saveMinutes = UserDefaults.standard.value(forKey: "SOFminutes") ?? 0
        let saveSeconds = UserDefaults.standard.value(forKey: "SOFseconds") ?? 0
        let saveMilliseconds = UserDefaults.standard.value(forKey: "SOFmilliseconds") ?? 0
        
        let playMinutes = UserDefaults.standard.value(forKey: "playMinutes") ?? 0
        let playSeconds = UserDefaults.standard.value(forKey: "playSeconds") ?? 0
        let playMilliseconds = UserDefaults.standard.value(forKey: "playMilliseconds") ?? 0

        
        UserDefaults.standard.set(saveMinutes as! Int + minutes, forKey: "SOFminutes")
        UserDefaults.standard.set(saveSeconds as! Int + seconds, forKey: "SOFseconds")
        UserDefaults.standard.set(saveMilliseconds as! Int + milliseconds, forKey: "SOFmilliseconds")
        
        UserDefaults.standard.set(playMinutes as! Int + minutes, forKey: "playMinutes")
        UserDefaults.standard.set(playSeconds as! Int + seconds, forKey: "playSeconds")
        UserDefaults.standard.set(playMilliseconds as! Int + milliseconds, forKey: "playMilliseconds")
        
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        
        let rightBarButton = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(tapEndButton))
        navigationItem.rightBarButtonItem = rightBarButton
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    
    
    @objc func tapEndButton(){
        let nextVC = ResultViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setLayoutConstraints()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func setLayoutConstraints(){
        view.addSubview(humorTitleLabel)
        view.addSubview(humorContentLabel)
        view.addSubview(koreanContentBGView)
        view.addSubview(koreanContentLabel)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            humorTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            humorTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            humorContentLabel.topAnchor.constraint(equalTo: humorTitleLabel.bottomAnchor, constant: 10),
            humorContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            humorContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            humorContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            koreanContentBGView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            koreanContentBGView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            koreanContentBGView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            koreanContentBGView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
            koreanContentBGView.topAnchor.constraint(equalTo: humorContentLabel.bottomAnchor, constant: 10),
            
            koreanContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            koreanContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            koreanContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            koreanContentLabel.topAnchor.constraint(equalTo: koreanContentBGView.topAnchor),
            koreanContentLabel.centerYAnchor.constraint(equalTo: koreanContentBGView.centerYAnchor),
            
            
            playButton.widthAnchor.constraint(equalToConstant: (view.bounds.width / 6) * 4),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            playButton.heightAnchor.constraint(equalToConstant: ((view.bounds.width / 7) * 3) / 2)
            
            
            
        ])
        
    }
    
}

