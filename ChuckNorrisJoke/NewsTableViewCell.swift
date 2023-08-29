//
//  NewsTableViewCell.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/24.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell{
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 0
//        label.text = "경기도 수원시"
        label.font = UIFont(name: "Noto Sans Myanmar", size: 15)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
//        label.text = "희망나눔 페스티벌 2016"
        label.numberOfLines = 0
        label.font = UIFont(name: "Noto Sans Myanmar", size: 12)
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
//        label.text = "관리자 | 031-230-1692~4"
        label.numberOfLines = 0
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
           contentView.addSubview(authorLabel)
           contentView.addSubview(titleLabel)
           contentView.addSubview(descriptionLabel)
           
           
           NSLayoutConstraint.activate([
            
            img.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            img.heightAnchor.constraint(equalToConstant: 140),
            img.widthAnchor.constraint(equalToConstant: 140),
            
               authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               authorLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
               authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
               
               
               titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
               titleLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
               titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
               descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
               descriptionLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 16),
               descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               
           ])
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
