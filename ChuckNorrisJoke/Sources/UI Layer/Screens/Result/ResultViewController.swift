//
//  ResultViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/15.
//

import UIKit
import Lottie

class ResultViewController: UIViewController{
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Great job 👍"
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let timeSpentLabel: UILabel = {
        let label = UILabel()
        label.text = "Time spent"
        label.textColor = .darkGray
        label.font = UIFont(name: "Noto Sans Myanmar", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let resultBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "7cec8f")
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resultLineview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "1a4321")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var homeButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(hexCode: "331D2C")
        button.layer.cornerRadius = 30
        button.setTitle("Go Home", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapHomeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    @objc func tapHomeButton(_ sender: UIButton){
        
        //MARK: 홈버튼 만들어서 홈으로 이동하기 모든 뷰를 팝하고
        navigationController?.popToRootViewController(animated: true)
    }
    
    private var animationView: LottieAnimationView = .init(name: "animation_llc03wvm.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        animationSetConstraints()
        setConstraints()
        
        
    }
    
    
    
    func setStackView(text: String, score: String) -> UIStackView{
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(name: "Noto Sans Myanmar", size: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let scoreLabel = UILabel()
        scoreLabel.text = score
        scoreLabel.textColor = .darkGray
        scoreLabel.font = UIFont(name: "Noto Sans Myanmar", size: 18)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.distribution = .equalCentering
        stackview.alignment = .center
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(scoreLabel)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
        
    }
    
    
    private func setConstraints(){
        
        let playCount = (UserDefaults.standard.value(forKey: "playCount") ?? 0) as! Int
        
        let playMinutes = UserDefaults.standard.value(forKey: "playMinutes") ?? 0
        let playSeconds = UserDefaults.standard.value(forKey: "playSeconds") ?? 0
        let playMilliseconds = UserDefaults.standard.value(forKey: "playMilliseconds") ?? 0
        
        var playTime = ""
        
        
        if playMilliseconds as! Int > 999{
            
            let addseconds = playMilliseconds as! Int / 1000
            
            //밀리언 초가 1000이상이고 초에 1을 더했을겨
            if playSeconds as! Int + addseconds > 59{
                let seconds = (playSeconds as! Int + addseconds) % 60
                let minutes = ((playSeconds as! Int + addseconds) / 60)
                playTime = "\(minutes + (playMinutes as! Int))m \(seconds)s"
            }
            else{
                playTime = "\(playMinutes)m \(playSeconds as! Int + addseconds)s"
            }
        }
        else{ //밀리언 초가 1000이하 초가 60이상일때
            if playSeconds as! Int > 59{
               let minutes = (playMinutes as! Int) + ((playSeconds as! Int) / 60)
                let seconds = (playSeconds as! Int) % 60
                playTime = "\(minutes)m \(seconds)s"
            }
            else{
                //밀리언 초가 1000이하이고 초가 59이하일때
                playTime = "\(playMinutes)m \(playSeconds)s"
            }
        }
        let speedyAnswersStackView = setStackView(text: "Speedy answers", score: String(playCount))
        let timeSpentStackview = setStackView(text: "Time spent", score: playTime)
        
        view.addSubview(commentLabel)
        view.addSubview(resultBGView)
        resultBGView.addSubview(resultLineview)
        resultBGView.addSubview(speedyAnswersStackView)
        resultBGView.addSubview(timeSpentStackview)
        view.addSubview(homeButton)
        
        commentLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        commentLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: view.bounds.height / 50).isActive = true
        
        resultBGView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        resultBGView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: view.bounds.height / 50).isActive = true
        resultBGView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        resultBGView.heightAnchor.constraint(equalToConstant: view.bounds.height / 5).isActive = true
        
        resultLineview.centerYAnchor.constraint(equalTo: resultBGView.centerYAnchor).isActive = true
        resultLineview.centerXAnchor.constraint(equalTo: resultBGView.centerXAnchor).isActive = true
        resultLineview.heightAnchor.constraint(equalToConstant: 1).isActive = true
        resultLineview.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        
        speedyAnswersStackView.centerXAnchor.constraint(equalTo: resultBGView.centerXAnchor).isActive = true
        speedyAnswersStackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 10 - 1).isActive = true
        speedyAnswersStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        speedyAnswersStackView.topAnchor.constraint(equalTo: resultBGView.topAnchor, constant: 0).isActive = true
        
        timeSpentStackview.centerXAnchor.constraint(equalTo: resultBGView.centerXAnchor).isActive = true
        timeSpentStackview.heightAnchor.constraint(equalToConstant: view.bounds.height / 10 - 1).isActive = true
        timeSpentStackview.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        timeSpentStackview.bottomAnchor.constraint(equalTo: resultBGView.bottomAnchor, constant: 0).isActive = true
        
        NSLayoutConstraint.activate([
            homeButton.heightAnchor.constraint(equalToConstant: ((view.bounds.width / 7) * 3) / 2),
            homeButton.widthAnchor.constraint(equalToConstant: (view.bounds.width / 6) * 4),
            homeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func animationSetConstraints(){
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.height/7, height: view.bounds.height/7)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .autoReverse
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height / 13)
        ])
    }
}
