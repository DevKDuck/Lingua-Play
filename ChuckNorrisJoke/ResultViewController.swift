//
//  ResultViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/15.
//

import UIKit
import Lottie

class ResultViewController: UIViewController{
    
    var animationView: LottieAnimationView = .init(name: "animation_llc03wvm.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        self.view.backgroundColor = .white
        self.view.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.height/7, height: view.bounds.height/7)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.play()
    }
    
}
