//
//  NewsDetailContentViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/25.
//

import Foundation
import UIKit
import Kingfisher
import FloatingPanel



class NewsDetailContentViewController: UIViewController, FloatingPanelControllerDelegate{
    
    var imgUrl: String = ""
    
    var fpc: FloatingPanelController!
    
    
    let imgView: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange

        setLayoutConstraints()
        setimgView()
        setFloatingPanel()

        
//        setBottomSheet()
    }
    
    func setFloatingPanel(){
        fpc = FloatingPanelController()
        
        fpc.delegate = self
        
        let contentVC = NewsBottomSheetViewController()
        fpc.addPanel(toParent: self)
        fpc.changePanelStyle()
//        fpc.track(scrollView: contentVC)
        fpc.set(contentViewController: contentVC)
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout()
    
    }
    
    func setBottomSheet(){
        let vc = NewsBottomSheetViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    func setimgView(){
        imgView.kf.setImage(with: URL(string:imgUrl))
    }
    
    
    func setLayoutConstraints() {
        view.addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)
        ])
    }
    
    
}

extension FloatingPanelController {
    func changePanelStyle() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: -4.0)
        shadow.opacity = 0.15
        shadow.radius = 2
        appearance.shadows = [shadow]
        appearance.cornerRadius = 15.0
        appearance.backgroundColor = .clear
        appearance.borderColor = .clear
        appearance.borderWidth = 0

        surfaceView.grabberHandle.isHidden = true
        surfaceView.appearance = appearance

    }
}


class MyFloatingPanelLayout: FloatingPanelLayout {
    var layoutBottomInset: CGFloat = UIScreen.main.bounds.height / 2 // floating panel의 길이 조정 (밑 anchors 변수에 사용)

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: layoutBottomInset, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
