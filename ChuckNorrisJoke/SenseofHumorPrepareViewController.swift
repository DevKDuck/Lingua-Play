//
//  SenseofHumorPrepareViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/05.
//

import UIKit

class SenseofHumorPrepareViewController: UIViewController{
    
    var gameIdentifier = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        setTopViewLayoutConstraints()
    }
    let topBGView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        return view
    }()
    
    let topIconBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.tintColor = .darkGray
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let statsLabel: UILabel = {
        let label = UILabel()
        label.text = "Stats"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 17)
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"Noto Sans Myanmar", size: 25)
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let subtitlelabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name:"Noto Sans Myanmar", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }()

    
    func setStatsStackView(){
        
        let bgview1 = UIView()
        bgview1.backgroundColor = .white
        bgview1.layer.cornerRadius = 15
        bgview1.translatesAutoresizingMaskIntoConstraints = false
        
        let bgview2 = UIView()
        bgview2.backgroundColor = .white
        bgview2.layer.cornerRadius = 15
        bgview2.translatesAutoresizingMaskIntoConstraints = false
        
        
        let titlelabel1 = UILabel()
        titlelabel1.text = "Number of plays"
        titlelabel1.font = UIFont(name: "Noto Sans Myanmar", size: 13)
        titlelabel1.textColor = .darkGray
        titlelabel1.textAlignment = .center
        titlelabel1.translatesAutoresizingMaskIntoConstraints = false
        
        
        let saveMinutes = UserDefaults.standard.value(forKey: "SOFminutes") ?? 0
        let saveSeconds = UserDefaults.standard.value(forKey: "SOFseconds") ?? 0
        let saveMilliseconds = UserDefaults.standard.value(forKey: "SOFmilliseconds") ?? 0
         let saveNum = UserDefaults.standard.value(forKey: "NumbersOfPlays")
        
        let contentlabel1 = UILabel()
        contentlabel1.text =  "\(saveNum ?? 0)"
        contentlabel1.font = UIFont(name: "Noto Sans Myanmar", size: 25)
        contentlabel1.font = .boldSystemFont(ofSize: 25)
        contentlabel1.textColor = .darkGray
        contentlabel1.textAlignment = .center
        contentlabel1.translatesAutoresizingMaskIntoConstraints = false
        
        let titlelabel2 = UILabel()
        titlelabel2.text = "Accumulated time"
        titlelabel2.font = UIFont(name: "Noto Sans Myanmar", size: 13 )
        titlelabel2.textColor = .darkGray
        titlelabel2.textAlignment = .center
        titlelabel2.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        let contentlabel2 = UILabel()
        
        //밀리언 초가 1000이상
        if saveMilliseconds as! Int > 999{
            
            let addseconds = saveMilliseconds as! Int / 1000
            
            //밀리언 초가 1000이상이고 초에 1을 더했을겨
            if saveSeconds as! Int + addseconds > 59{
                let seconds = (saveSeconds as! Int + addseconds) % 60
                let minutes = ((saveSeconds as! Int + addseconds) / 60)
                contentlabel2.text = "\(minutes + (saveMinutes as! Int))m \(seconds)s"
            }
            else{
                contentlabel2.text = "\(saveMinutes)m \(saveSeconds as! Int + addseconds)s"
            }
        }
        else{ //밀리언 초가 1000이하 초가 60이상일때
            if saveSeconds as! Int > 59{
               let minutes = (saveMinutes as! Int) + ((saveSeconds as! Int) / 60)
                let seconds = (saveSeconds as! Int) % 60
                contentlabel2.text = "\(minutes)m \(seconds)s"
            }
            else{
                //밀리언 초가 1000이하이고 초가 59이하일때
                contentlabel2.text = "\(saveMinutes)m \(saveSeconds)s"
            }
        }
        
        contentlabel2.font = .boldSystemFont(ofSize: 25)
        
        contentlabel2.textColor = .darkGray
        contentlabel2.textAlignment = .center
        contentlabel2.translatesAutoresizingMaskIntoConstraints = false
 
        topBGView.addSubview(bgview1)
        topBGView.addSubview(bgview2)
        bgview1.addSubview(titlelabel1)
        bgview1.addSubview(contentlabel1)
        bgview2.addSubview(titlelabel2)
        bgview2.addSubview(contentlabel2)
        
        NSLayoutConstraint.activate([
            
            bgview1.leadingAnchor.constraint(equalTo: topBGView.leadingAnchor, constant: 15),
            bgview1.widthAnchor.constraint(equalToConstant: (view.bounds.width / 2) - 35),
            bgview1.topAnchor.constraint(equalTo: statsLabel.bottomAnchor,constant: 10),
            bgview1.bottomAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: -10),
            
            contentlabel1.centerXAnchor.constraint(equalTo: bgview1.centerXAnchor),
            contentlabel1.leadingAnchor.constraint(equalTo: bgview1.leadingAnchor),
            contentlabel1.trailingAnchor.constraint(equalTo: bgview1.trailingAnchor),
            contentlabel1.topAnchor.constraint(equalTo: bgview1.topAnchor, constant: 20),
            
            titlelabel1.centerXAnchor.constraint(equalTo: bgview1.centerXAnchor),
            titlelabel1.leadingAnchor.constraint(equalTo: bgview1.leadingAnchor),
            titlelabel1.trailingAnchor.constraint(equalTo: bgview1.trailingAnchor),
            titlelabel1.topAnchor.constraint(equalTo: contentlabel1.bottomAnchor, constant: 10),
            
            bgview2.trailingAnchor.constraint(equalTo: topBGView.trailingAnchor, constant: -15),
            bgview2.widthAnchor.constraint(equalToConstant: (view.bounds.width / 2) - 35),
            bgview2.topAnchor.constraint(equalTo: statsLabel.bottomAnchor,constant: 10),
            bgview2.bottomAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: -10),
            
            contentlabel2.centerXAnchor.constraint(equalTo: bgview2.centerXAnchor),
            contentlabel2.leadingAnchor.constraint(equalTo: bgview2.leadingAnchor),
            contentlabel2.trailingAnchor.constraint(equalTo: bgview2.trailingAnchor),
            contentlabel2.topAnchor.constraint(equalTo: bgview2.topAnchor, constant: 20),
            
            titlelabel2.centerXAnchor.constraint(equalTo: bgview2.centerXAnchor),
            titlelabel2.leadingAnchor.constraint(equalTo: bgview2.leadingAnchor),
            titlelabel2.trailingAnchor.constraint(equalTo: bgview2.trailingAnchor),
            titlelabel2.topAnchor.constraint(equalTo: contentlabel2.bottomAnchor, constant: 10)
            
        ])
        
        
    }
    
    let benefitLabel: UILabel = {
        let label = UILabel()
        label.text = "Benefit"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setBenefitStackView(){
        
        let view1: UIView
        let view2: UIView
        
        
        if gameIdentifier == "GuessingWords"{
            view1 = createBenefitStackView(text: "Think carefully about the words translated into Korean")
            view2 = createBenefitStackView(text: "It could be a picture related to a word or not, and there could be a hint in the image")
        }
        else{
            view1 = createBenefitStackView(text: "Read the joke and infer the meaning of the sentence")
            
            view2 = createBenefitStackView(text: "Press the translation button to check if the inferences are correct")
        }
        
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: benefitLabel.bottomAnchor, constant: 20),
            view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            view1.heightAnchor.constraint(equalToConstant: (view.bounds.height / 5) / 2),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 20),
            view2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            view2.heightAnchor.constraint(equalToConstant: (view.bounds.height / 5) / 2),
            
            playButton.heightAnchor.constraint(equalToConstant: ((view.bounds.width / 7) * 3) / 2),
            playButton.widthAnchor.constraint(equalToConstant: (view.bounds.width / 6) * 4),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
    
    func createBenefitStackView(text: String) -> UIStackView{
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "book.closed.circle")
        imageView.tintColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Noto Sans Myanmar", size: 17)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }
    
    
    lazy var playButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(hexCode: "331D2C")
        button.layer.cornerRadius = 30
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapPlayButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tapPlayButton(_ sender: UIButton){
        let vc: UIViewController
        if gameIdentifier == "GuessingWords"{
            vc = ImageGameViewController()
        }
        else{
            vc = SenseOfHumorViewController()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTopViewLayoutConstraints()
        benefitConstraints()
        setContentUI()
    }
    
    func setContentUI(){
        if gameIdentifier == "GuessingWords"{
            topBGView.backgroundColor = UIColor(hexCode: "DBC4F0")
            topIcon.image = UIImage(systemName: "brain.head.profile")
            titleLabel.text = "Gussing Words"
            subtitlelabel.text = "Try to guess words"
        }
        else{
            topBGView.backgroundColor = UIColor(hexCode: "FFCACC")
            topIcon.image = UIImage(systemName: "text.bubble" )
            titleLabel.text = "Sense Of Humor"
            subtitlelabel.text = "Think of the sentence"
        }
    }
    
    func setTopViewLayoutConstraints(){
        view.addSubview(topBGView)
        topBGView.addSubview(topIconBGView)
        topBGView.addSubview(titleLabel)
        topBGView.addSubview(subtitlelabel)
        topIconBGView.addSubview(topIcon)
        topBGView.addSubview(statsLabel)
        
        
        
        NSLayoutConstraint.activate([
            topBGView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topBGView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            topBGView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            topBGView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2 - 44),
            
            topIconBGView.topAnchor.constraint(equalTo: topBGView.topAnchor, constant: (view.bounds.height / 2) / 6),
            topIconBGView.centerXAnchor.constraint(equalTo: topBGView.centerXAnchor),
            topIconBGView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 2) / 6),
            topIconBGView.widthAnchor.constraint(equalToConstant: (view.bounds.height / 2) / 6),
            
            topIcon.centerYAnchor.constraint(equalTo: topIconBGView.centerYAnchor),
            topIcon.centerXAnchor.constraint(equalTo: topIconBGView.centerXAnchor),
            topIcon.heightAnchor.constraint(equalToConstant: (view.bounds.height / 2) / 6 * 0.8),
            topIcon.widthAnchor.constraint(equalToConstant: (view.bounds.height / 2) / 6 * 0.8),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: topBGView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: topBGView.trailingAnchor, constant: -10),
            
//            titleLabel.heightAnchor.constraint(equalToConstant:  (view.bounds.height / 2) / 6 * 0.65),
            titleLabel.centerXAnchor.constraint(equalTo: topBGView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topIconBGView.bottomAnchor, constant: 10),
            
 
            subtitlelabel.leadingAnchor.constraint(equalTo: topBGView.leadingAnchor, constant: 10),
            subtitlelabel.trailingAnchor.constraint(equalTo: topBGView.trailingAnchor, constant: -10),
            
//            titleLabel.heightAnchor.constraint(equalToConstant:  (view.bounds.height / 2) / 6 * 0.65),
            subtitlelabel.centerXAnchor.constraint(equalTo: topBGView.centerXAnchor),
            subtitlelabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            
            statsLabel.leadingAnchor.constraint(equalTo: topBGView.leadingAnchor, constant: 15),
            statsLabel.topAnchor.constraint(equalTo: subtitlelabel.bottomAnchor, constant: 15),
            statsLabel.heightAnchor.constraint(equalToConstant: 30)
            
            
            
        ])
        setStatsStackView()
        
    }
    
    func benefitConstraints(){
        view.addSubview(benefitLabel)
        view.addSubview(playButton)
        
        
        NSLayoutConstraint.activate([
            benefitLabel.topAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: 20),
            benefitLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            benefitLabel.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        setBenefitStackView()
    }
    
}
