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
    
    let senseOfHumorBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "FFCACC")
        view.layer.cornerRadius = 25
        return view
    }()
    
    let senseOfHumorIconBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let senseOfHumorIconView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "brain")
        imageview.tintColor = .darkGray
        return imageview
    }()
    
    
    let senseOfHumorLabelStackView: UIStackView = {
        let senseOfHumorTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Sense of Humor"
            label.textColor = .darkGray
            label.font = UIFont(name: "Noto Sans Myanmar", size: 20)
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        let senseOfHumorSubtitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Think of the sentence"
            label.textColor = .darkGray
            label.font = UIFont(name: "Noto Sans Myanmar", size: 15)
            return label
        }()
        
        
        let stackView = UIStackView(arrangedSubviews: [senseOfHumorTitleLabel, senseOfHumorSubtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    @objc func tapsenseOfHumorButton(_ sender: UITapGestureRecognizer){
        guard let vc = storyboard?.instantiateViewController(identifier: "SenseOfHumorViewController") else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
//    lazy var senseOfHumorButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Sense of Humor", for: .normal)
//        button.setTitleColor(.darkGray, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Noto Sans Myanmar", size: 20)
//        button.backgroundColor = UIColor(hexCode: "FFCACC")
//        button.layer.cornerRadius = 15
//        button.addTarget(self, action: #selector(tapsenseOfHumorButton(_:)), for: .touchUpInside)
//        return button
//    }()
//    
    
    lazy var inferGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Infer Game", for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = UIColor(hexCode: "DBC4F0")
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
        
        
        view.backgroundColor = .white
        setLayourConstraints()
        addTapGesture()
    }
    
    func addTapGesture(){
        senseOfHumorBGView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapsenseOfHumorButton(_:))))
    }
    
    func setLayourConstraints(){
        view.addSubview(titleLabel)
        view.addSubview(senseOfHumorBGView)
        senseOfHumorBGView.addSubview(senseOfHumorIconBGView)
        senseOfHumorBGView.addSubview(senseOfHumorLabelStackView)
        senseOfHumorIconBGView.addSubview(senseOfHumorIconView)
        view.addSubview(inferGameButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        senseOfHumorIconBGView.translatesAutoresizingMaskIntoConstraints = false
        senseOfHumorBGView.translatesAutoresizingMaskIntoConstraints = false
        senseOfHumorIconView.translatesAutoresizingMaskIntoConstraints = false
        senseOfHumorLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        inferGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            
            senseOfHumorBGView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            senseOfHumorBGView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width / 30),
            senseOfHumorBGView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(view.bounds.width / 30)),
            senseOfHumorBGView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 80),
            senseOfHumorBGView.heightAnchor.constraint(equalToConstant: view.bounds.height / 6),
            
            senseOfHumorIconBGView.leadingAnchor.constraint(equalTo: senseOfHumorBGView.leadingAnchor, constant: view.bounds.width / 20),
            senseOfHumorIconBGView.centerYAnchor.constraint(equalTo: senseOfHumorBGView.centerYAnchor),
            senseOfHumorIconBGView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2),
            senseOfHumorIconBGView.widthAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2),
            
            
            senseOfHumorIconView.centerYAnchor.constraint(equalTo: senseOfHumorIconBGView.centerYAnchor),
            senseOfHumorIconView.centerXAnchor.constraint(equalTo: senseOfHumorIconBGView.centerXAnchor),
            senseOfHumorIconView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2 * 0.8),
            senseOfHumorIconView.widthAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2 * 0.8),
            
            senseOfHumorLabelStackView.centerYAnchor.constraint(equalTo: senseOfHumorIconBGView.centerYAnchor),
            senseOfHumorLabelStackView.leadingAnchor.constraint(equalTo:senseOfHumorIconBGView.trailingAnchor, constant: view.bounds.width / 20),
            senseOfHumorLabelStackView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2),
            senseOfHumorLabelStackView.widthAnchor.constraint(equalToConstant: (view.bounds.width / 2)),
            
            
            
            
            inferGameButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            inferGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            inferGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            inferGameButton.topAnchor.constraint(equalTo: senseOfHumorBGView.bottomAnchor,constant: 20),
            inferGameButton.heightAnchor.constraint(equalToConstant:view.bounds.height / 6)
        ])
    }
    
    
}


extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

//색깔convienece bound , frame 정리
