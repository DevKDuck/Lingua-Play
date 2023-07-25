//
//  ImageGameViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/25.
//

import UIKit

class ImageGameViewController: UIViewController{
    
    let fixImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 갱신 버튼", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setConstraints()
    }
    
    func setConstraints(){
        
        self.view.addSubview(fixImageButton)
        
        fixImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            fixImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            fixImageButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            fixImageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            fixImageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            fixImageButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
}
