//
//  NewsTableViewCell.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/24.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell{
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
//        label.text = "경기도 수원시"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 15)
        return label
    }()
    
    let festivalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
//        label.text = "희망나눔 페스티벌 2016"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 10)
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    let regDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
//        label.text = "관리자 | 031-230-1692~4"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 10)
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    let img: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .orange
        imgView.image = UIImage(systemName: "camera.macro")
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = 20
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           contentView.backgroundColor = .white
           contentView.addSubview(img)
           contentView.addSubview(cityLabel)
           contentView.addSubview(festivalTitleLabel)
           contentView.addSubview(regDateLabel)
           
           
           NSLayoutConstraint.activate([
            
            img.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            img.heightAnchor.constraint(equalToConstant: 140),
            img.widthAnchor.constraint(equalToConstant: 140),
            
               cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               cityLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
               cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
               
               
               festivalTitleLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
               festivalTitleLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
               festivalTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
               regDateLabel.topAnchor.constraint(equalTo: festivalTitleLabel.bottomAnchor, constant: 4),
               regDateLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
               regDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
           ])
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
