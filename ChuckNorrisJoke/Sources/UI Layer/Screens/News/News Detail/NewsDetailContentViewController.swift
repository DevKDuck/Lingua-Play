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
import Then
import SnapKit



class NewsDetailContentViewController: UIViewController, FloatingPanelControllerDelegate{
    
    var imgUrl: String = ""
    
    var bottomSheetDescription: String = ""
    var bottomSheetContent: String = ""
    var fpc: FloatingPanelController!
    
    
//    let imgView: UIImageView = {
//       let img = UIImageView()
//        img.translatesAutoresizingMaskIntoConstraints = false
//        img.contentMode = .scaleToFill
//        return img
//    }()
//
    let imgView = UIImageView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
    }
    
    lazy var backButton = UIButton().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(tapBackButton(_:)), for: .touchUpInside)
        $0.setImage(UIImage(systemName: "chevron.backward.circle"), for: .normal)
        $0.tintColor = .lightGray
    }
    
    var titleLabel = UILabel().then{
//        $0.text = "Alexandar wears modified helmet in roads races"
        $0.textColor = .white
        $0.font = UIFont(name: "Noto Sans Myanmar", size: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        
        var text = ""
        var attributedText = NSMutableAttributedString(string: text)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        attributedText.addAttributes([.font:UIFont.boldSystemFont(ofSize: 24)], range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        $0.attributedText = attributedText

    }
    
    
    @objc func tapBackButton(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange

        setLayoutConstraints()
        setimgView()
        setFloatingPanel(description: bottomSheetDescription, content: bottomSheetContent)

        
//        setBottomSheet()
    }
    
    func setFloatingPanel(description: String, content: String){
        fpc = FloatingPanelController()
        
        fpc.delegate = self
        
        let contentVC = NewsBottomSheetViewController()
        contentVC.contentLabel.text = "Content:  \(content)"
        contentVC.descriptionLabel.text = "Description:  \(description)"
        
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
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        imgView.snp.makeConstraints{ v in
            v.top.equalTo(self.view)
            v.left.right.equalToSuperview()
            v.height.equalTo(view.bounds.height / 2)
        }
        
        backButton.snp.makeConstraints{b in
            b.top.equalTo(self.view).offset(50)
            b.left.equalTo(self.view).offset(10)
            b.height.equalTo(44)
            b.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints{l in
            l.bottom.equalTo(imgView).offset(-80)
            l.left.equalTo(self.view).offset(15)
            l.trailing.equalTo(self.view).offset(-15)
        }
        
//        NSLayoutConstraint.activate([
//            imgView.topAnchor.constraint(equalTo: view.topAnchor),
//            imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            imgView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)
//        ])
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
