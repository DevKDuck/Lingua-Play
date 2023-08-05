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
        titlelabel.font = UIFont(name:"Noto Sans Myanmar", size: 35)
        titlelabel.font = .boldSystemFont(ofSize: 35)
        titlelabel.textColor = .darkGray
        titlelabel.textAlignment = .center
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitlelabel = UILabel()
        subtitlelabel.text = "Think of the sentence"
        subtitlelabel.textColor = .darkGray
        subtitlelabel.font = UIFont(name:"Noto Sans Myanmar", size: 20)
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
            topBGView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2),
            
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
            topLabelstackView.centerYAnchor.constraint(equalTo: topBGView.centerYAnchor)
        ])
        
    }
    
    func benefitConstraints(){
        view.addSubview(benefitLabel)
        
        NSLayoutConstraint.activate([
        benefitLabel.topAnchor.constraint(equalTo: topBGView.bottomAnchor, constant: 20),
        benefitLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        
        ])
        
    }
    
}
