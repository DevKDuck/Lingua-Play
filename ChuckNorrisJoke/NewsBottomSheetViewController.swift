//
//  NewsBottomSheetViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/28.
//

import Foundation
import UIKit


class NewsBottomSheetViewController: UIViewController{

    
    let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        setupUI()
    }
    
    private func setupUI() {
            view.addSubview(dimmedView)
            
            setupLayout()
        }
        
        // 4
    private func setupLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
