//
//  SenseofHumorPrepareViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/05.
//

import UIKit

class SenseofHumorPrepareViewController: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    let topBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "FFCACC")
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
        imageview.image = UIImage(systemName: "text.bubble" )
        imageview.tintColor = .darkGray
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    
    
    
    let topLabelstackView: UIStackView = {
        let titlelabel = UILabel()
        titlelabel.text = "Sense Of Humor"
        titlelabel.font = UIFont(name:"Noto Sans Myanmar", size: 25)
        titlelabel.font = .boldSystemFont(ofSize: 25)
        titlelabel.textColor = .darkGray
        titlelabel.textAlignment = .center
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitlelabel = UILabel()
        subtitlelabel.text = "Think of the sentence"
        subtitlelabel.textColor = .darkGray
        subtitlelabel.font = UIFont(name:"Noto Sans Myanmar", size: 17)
        subtitlelabel.translatesAutoresizingMaskIntoConstraints = false
        subtitlelabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [titlelabel,subtitlelabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0.1
        
        return stackView
    }()
    
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
        let view1 = createBenefitStackView(text: "Read the joke and infer the meaning of the sentence")
        
        let view2 = createBenefitStackView(text: "Press the translation button to check if the inferences are correct")
        
        
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
//        guard let vc = storyboard?.instantiateViewController(withIdentifier:  "SenseOfHumorViewController") else {
//            return
//        }
        
        let v = SenseOfHumorViewController()
        self.navigationController?.pushViewController(v, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTopViewLayoutConstraints()
        benefitConstraints()
    }
    
    func setTopViewLayoutConstraints(){
        view.addSubview(topBGView)
        topBGView.addSubview(topIconBGView)
        topBGView.addSubview(topLabelstackView)
        topIconBGView.addSubview(topIcon)
        
        
        
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
            
            
            topLabelstackView.widthAnchor.constraint(equalToConstant:  (view.bounds.height / 2)),
            topLabelstackView.heightAnchor.constraint(equalToConstant:  (view.bounds.height / 2) / 5),
            topLabelstackView.centerXAnchor.constraint(equalTo: topBGView.centerXAnchor),
            topLabelstackView.centerYAnchor.constraint(equalTo: topBGView.centerYAnchor),
            
            
        ])
        
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
