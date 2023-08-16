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
        
        let speedyAnswersStackView = setStackView(text: "Speedy answers", score: "0")
        let timeSpentStackview = setStackView(text: "Time spent", score: "00:48")
        
        view.addSubview(commentLabel)
        view.addSubview(resultBGView)
        resultBGView.addSubview(resultLineview)
        resultBGView.addSubview(speedyAnswersStackView)
        resultBGView.addSubview(timeSpentStackview)
        
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
