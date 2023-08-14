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
    
    lazy var senseOfHumorBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "FFCACC")
        view.layer.cornerRadius = 25
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapsenseOfHumorButton(_:))))
        return view
    }()
    
    lazy var inferGameBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DBC4F0")
        view.layer.cornerRadius = 25
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapInferGameButton(_:))))
        return view
    }()

    @objc func tapsenseOfHumorButton(_ sender: UITapGestureRecognizer){
//        guard let vc = storyboard?.instantiateViewController(withIdentifier:  "SenseOfHumorViewController") else { return}
        
        let vc = PrepareViewController()
        vc.gameIdentifier = "SenseOfHumon"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc func tapInferGameButton(_ sender: UIButton){
        let vc = PrepareViewController()
        vc.gameIdentifier = "GuessingWords"
        self.navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .fullScreen
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
        label.text = labelText
        label.textColor = .darkGray
        label.font = UIFont(name: "Noto Sans Myanmar", size: fontSize)
        if boldBool == true{
            label.font = .boldSystemFont(ofSize: fontSize)
        }
        return label
    }
    
    //StackView 생성
    func setLabelStackView(titleLabel: String, titleFontSize: CGFloat, titleBoldBool: Bool,
                           subLabel: String, subFontSize: CGFloat, subBoldBool: Bool) -> UIStackView{
        let titleLabel = setTitleAndSubLabel(labelText: titleLabel, fontSize: titleFontSize, boldBool: titleBoldBool)
        let subTitleLabel = setTitleAndSubLabel(labelText: subLabel, fontSize: subFontSize, boldBool: subBoldBool)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }
    
    //버튼 생성
    func setButton(){
        constraintButton(bgView: senseOfHumorBGView, iconImage: "text.bubble", titleLabel: "Sense Of Humor", titleFontSize: 20, titleBoldBool: true, subLabel: "Think of the sentence", subFontSize: 15, subBoldBool: false, constraintTopView: titleLabel, betweenViewDistance: 100)
        constraintButton(bgView: inferGameBGView, iconImage: "brain.head.profile", titleLabel: "Gussing Words", titleFontSize: 20, titleBoldBool: true, subLabel: "Try to guess words", subFontSize: 15, subBoldBool: false, constraintTopView: senseOfHumorBGView, betweenViewDistance: 30)
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
            
            stackView.centerYAnchor.constraint(equalTo: iconBGView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo:iconBGView.trailingAnchor, constant: view.bounds.width / 20),
            stackView.heightAnchor.constraint(equalToConstant: (view.bounds.height / 6) / 2),
            stackView.widthAnchor.constraint(equalToConstant: (view.bounds.width / 2)),
            
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
