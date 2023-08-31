//
//  LogInViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/03.
//

import UIKit
import Alamofire
import Kingfisher


class NewsViewController: UITableViewController{
   
    
    var authorArray = [String]()
    var titleArray = [String]()
    var descriptionArray = [String]()
    var imgUrlArray = [String]()
    var contentArray = [String]()
    
    var lastContentOffset: CGFloat = 0
    
    func fetchData(){
        let url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6cadc26e16894316aff6cfde14050ba5"
        
//        let headers: HTTPHeaders = ["accept" : "application/json"]
        AF.request(url, method: .get, parameters: nil).validate(statusCode: 200..<300).responseDecodable(of: NewsAPI.self){ response in
            switch response.result{
            case.success(let datas):
                for data in datas.articles{
                    self.titleArray.append(data.title)
                    self.descriptionArray.append(data.description)
                    self.authorArray.append(data.author)
                    self.imgUrlArray.append(data.urlToImage)
                    self.contentArray.append(data.content ?? "Have No content")
                }
                self.tableView.reloadData()
               
            case .failure(let err):
                print("Fetch NewsAPI Data \(err.localizedDescription)")
            }
        }
    }
   
    

    let festivalNewsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
        label.text = "Festival News"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchData()
        setTableView()

    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authorArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        cell.authorLabel.text = authorArray[indexPath.row]
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.descriptionLabel.text = "Content: \(descriptionArray[indexPath.row])"
        
        
        let imageURLStr = imgUrlArray[indexPath.row]
        cell.img.kf.setImage(with: URL(string: imageURLStr))
        return cell
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailContentViewController()
        vc.imgUrl = imgUrlArray[indexPath.row]
        vc.titleLabel.text = titleArray[indexPath.row]
        vc.bottomSheetContent = contentArray[indexPath.row]
        vc.bottomSheetDescription = descriptionArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let titleLabel: UILabel = {
           let label = UILabel()
            label.text = "Daily News"
            label.textColor = .darkGray
            label.font = .boldSystemFont(ofSize: 40)
            label.font = UIFont(name: "Noto Sans Myanmar", size: 40)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        headerView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.bounds.height / 7
    }
 
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.y


        if contentOffset > self.lastContentOffset {
            // 아래로 스크롤 중
            print("아래로 스크롤 중")
        } else if contentOffset < self.lastContentOffset {
            // 위로 스크롤 중
            print("위로 스크롤 중")
        }

        self.lastContentOffset = contentOffset
    }
}



