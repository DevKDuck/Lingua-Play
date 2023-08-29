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
    
    var lastContentOffset: CGFloat = 0
    
    func fetchData2(){
        let url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6cadc26e16894316aff6cfde14050ba5"
        
//        let headers: HTTPHeaders = ["accept" : "application/json"]
        AF.request(url, method: .get, parameters: nil).validate(statusCode: 200..<300).responseDecodable(of: News2.self){ response in
            switch response.result{
            case.success(let datas):
                for data in datas.articles{
                    self.titleArray.append(data.title)
                    self.descriptionArray.append(data.description)
                    self.authorArray.append(data.author)
                    self.imgUrlArray.append(data.urlToImage)
                }
                self.tableView.reloadData()
               
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
   
    
    
    func fetchData(serviceKey: String = NewsServiceKey().serviceKey, numberOfRows: Int, pageNo: Int){
        let url = "http://api.kcisa.kr/openapi/service/rest/meta4/getKCPG0504?serviceKey=\(serviceKey)&numOfRows=\(numberOfRows)&pageNo=\(pageNo)"
        
        let headers: HTTPHeaders = ["accept" : "application/json"]
        AF.request(url, method: .get, parameters: nil, headers: headers).validate(statusCode: 200..<300).responseDecodable(of: News.self){ response in
            switch response.result{
            case.success(let datas):
                for data in datas.response.body.items.item{
                    if let city = data.spatialCoverage, let title = data.title, let regDate = data.regDate,
                       let img = data.referenceIdentifier{
                        self.authorArray.append(city)
                        self.titleArray.append(title)
                        self.descriptionArray.append(regDate)
                        self.imgUrlArray.append(img)
                    }
                }
                self.tableView.reloadData()
               
            case .failure(let err):
                print(err.localizedDescription)
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
    
//    let view1 : UIView = {
//       let view = UIView()
//        view.bounds = CGRect(x: 200, y: 200, width: 150, height: 150)
//        view.backgroundColor = .blue
//        return view
//    }()
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchData(numberOfRows: 100, pageNo: 1)
        fetchData2()
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Daily News"
//    }
    
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



