//
//  HomeViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/07/29.
//

import UIKit
import Then
import SnapKit
import Foundation


class HomeViewController: UIViewController{

    //MARK: UI객체
    let titleLabel = UILabel().then{
        $0.textAlignment = .center
        $0.text = "Ligua Play"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 40)
    }
    
    lazy var senseOfHumorBGView = UIView().then{
        $0.backgroundColor = UIColor(hexCode: "FFCACC")
        $0.layer.cornerRadius = 25
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapsenseOfHumorButton(_:))))
    }
    
    lazy var inferGameBGView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "DBC4F0")
        $0.layer.cornerRadius = 25
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapInferGameButton(_:))))
    }

    lazy var newsBGView = UIView().then{
        $0.backgroundColor = UIColor(hexCode: "A8DF8E")
        $0.layer.cornerRadius = 25
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapNewsView(_:))))
    }
    
    
    
    //MARK: 액션 실행 Selector
    @objc func tapNewsView(_ sender: UITapGestureRecognizer){
        let vc = NewsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func tapsenseOfHumorButton(_ sender: UITapGestureRecognizer){
        let vc = PrepareViewController()
        vc.gameIdentifier = "SenseOfHumon"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func tapInferGameButton(_ sender: UIButton){
        let vc = PrepareViewController()
        vc.gameIdentifier = "GuessingWords"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleLabelLayoutConstraints()
        setButton()
    }
    
    
    //버튼 배경뷰
    func setBGView(color: String) -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: color)
        view.layer.cornerRadius = 25
        return view
    }
    
    //아이콘 배경뷰
    func setIconBGView() -> UIView{
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }
    
    //아이콘 이미지뷰
    func setIconView(systemimageName: String) -> UIImageView{
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: systemimageName)
        imageview.tintColor = .darkGray
        return imageview
    }
    
  
    //타이틀과 부제 라벨
    func setTitleAndSubLabel(labelText: String, fontSize: CGFloat, boldBool: Bool) -> UILabel{
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont(name: "Noto Sans Myanmar", size: fontSize)
        var attributedText = NSMutableAttributedString(string: labelText)
        if boldBool == true{
            attributedText.addAttributes([.font:UIFont.boldSystemFont(ofSize: 24)], range: NSRange(location: 0, length: attributedText.length))
        }
        label.attributedText = attributedText
        return label
    }
    
    //StackView 생성
    func setLabelStackView(titleLabel: String, titleFontSize: CGFloat, titleBoldBool: Bool,
                           subLabel: String, subFontSize: CGFloat, subBoldBool: Bool) -> UIStackView{
        let titleLabel = setTitleAndSubLabel(labelText: titleLabel, fontSize: titleFontSize, boldBool: titleBoldBool)
        let subTitleLabel = setTitleAndSubLabel(labelText: subLabel, fontSize: subFontSize, boldBool: subBoldBool)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    //버튼 생성
    func setButton(){
        constraintButton(bgView: senseOfHumorBGView, iconImage: "text.bubble", titleLabel: "Sense Of Humor", titleFontSize: 20, titleBoldBool: true, subLabel: "Think of the sentence", subFontSize: 15, subBoldBool: false, constraintTopView: titleLabel, betweenViewDistance: 60)
        constraintButton(bgView: inferGameBGView, iconImage: "brain.head.profile", titleLabel: "Gussing Words", titleFontSize: 20, titleBoldBool: true, subLabel: "Try to guess words", subFontSize: 15, subBoldBool: false, constraintTopView: senseOfHumorBGView, betweenViewDistance: 20)
        
        constraintButton(bgView: newsBGView, iconImage: "newspaper", titleLabel: "Daily News", titleFontSize: 20, titleBoldBool: true, subLabel: "Headline news provided by BBC News", subFontSize: 15, subBoldBool: false, constraintTopView: inferGameBGView, betweenViewDistance: 20)
    }
    
    //버튼 구성
    func constraintButton(bgView: UIView, iconImage: String, titleLabel: String, titleFontSize: CGFloat, titleBoldBool: Bool, subLabel: String, subFontSize: CGFloat, subBoldBool: Bool, constraintTopView: UIView, betweenViewDistance: CGFloat){
        let iconBGView = setIconBGView()
        let iconView = setIconView(systemimageName: iconImage)
        let stackView = setLabelStackView(titleLabel: titleLabel, titleFontSize: titleFontSize, titleBoldBool: titleBoldBool, subLabel: subLabel, subFontSize: subFontSize, subBoldBool: subBoldBool)
           
        view.addSubview(bgView)
        bgView.addSubview(iconBGView)
        bgView.addSubview(stackView)
        iconBGView.addSubview(iconView)
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        iconBGView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width / 30),
            bgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -(view.bounds.width / 30)),
            bgView.topAnchor.constraint(equalTo: constraintTopView.bottomAnchor,constant: betweenViewDistance),
            bgView.heightAnchor.constraint(equalToConstant:view.bounds.height / 6),
            
            iconBGView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: view.bounds.width / 20),
            iconBGView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            iconBGView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2),
            iconBGView.widthAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2),
            
            
            iconView.centerYAnchor.constraint(equalTo: iconBGView.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: iconBGView.centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2 * 0.8),
            iconView.widthAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2 * 0.8),
            
            stackView.leadingAnchor.constraint(equalTo:iconBGView.trailingAnchor, constant: view.bounds.width / 20),
            stackView.trailingAnchor.constraint(equalTo:bgView.trailingAnchor, constant: -(view.bounds.width / 20)),
            stackView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: (view.bounds.height / 6) * 0.1),
            stackView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -((view.bounds.height / 6) * 0.1)),
        ])
    }
    
    
    func titleLabelLayoutConstraints(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
        
        ])
    }
}
