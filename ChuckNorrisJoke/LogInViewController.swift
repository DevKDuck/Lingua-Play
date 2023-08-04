//
//  LogInViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/03.
//

import UIKit

class LogInViewController: UIViewController{
    
    let superView : UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        view.backgroundColor = .orange
        return view
    }()
    
    let view1 : UIView = {
       let view = UIView()
        view.bounds = CGRect(x: 200, y: 200, width: 150, height: 150)
        view.backgroundColor = .blue
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .white
        view.addSubview(superView)
        view.addSubview(view1)
    }
    
}
