//
//  HomeViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/29.
//

import UIKit

class HomeViewController: UIViewController{
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Ligua Play"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    lazy var senseOfHumorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sense of Humor", for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapsenseOfHumorButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tapsenseOfHumorButton(_ sender: UIButton){
        guard let vc = storyboard?.instantiateViewController(identifier: "SenseOfHumorViewController") else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    lazy var inferGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Infer Game", for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapInferGameButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func tapInferGameButton(_ sender: UIButton){
        let vc = ImageGameViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        setLayourConstraints()
    }
    
    func setLayourConstraints(){
        view.addSubview(titleLabel)
        view.addSubview(senseOfHumorButton)
        view.addSubview(inferGameButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        senseOfHumorButton.translatesAutoresizingMaskIntoConstraints = false
        inferGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            
            senseOfHumorButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            senseOfHumorButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            senseOfHumorButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            senseOfHumorButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 80),
            senseOfHumorButton.heightAnchor.constraint(equalToConstant: 70),
            
            inferGameButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            inferGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            inferGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            inferGameButton.topAnchor.constraint(equalTo: senseOfHumorButton.bottomAnchor,constant: 20),
            inferGameButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    
}
