//
//  LogInViewController.swift
//  ChuckNorrisJoke
//
//  Created by duck on 2023/08/03.
//

import UIKit
import Alamofire
import Kingfisher
import RxSwift
import RxCocoa
import Then
import RxDataSources

class NewsViewController: UIViewController{
    let disposeBag = DisposeBag()
    let viewmodel = Viewmodel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self,forCellReuseIdentifier: "NewsTableViewCell")
        tableView.rowHeight = 200
//        tableView.delegate = self
//        tableView.dataSource = self
        
        return tableView
    }()
    
    let textlabel = UILabel().then{
        $0.textColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.addSubview(textlabel)
        //        textlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        textlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        bindTableView()
        viewmodel.reload()
        
        selectedTableViewCell()
    }
    
    func bindTableView() {
 
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Model>>(
            configureCell: { (_, tableView, indexPath, item) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
                
                // Model의 속성을 Cell에 설정
                cell.titleLabel.text = item.newsTitle
                cell.descriptionLabel.text = item.newsDescription
                cell.authorLabel.text = item.newsAuthor
                cell.img.kf.setImage(with: URL(string: item.newsimageUrl))
                // 다른 필요한 데이터 설정
                
                return cell
            }
        )
        
        viewmodel.items.asDriver()
            .map { [SectionModel(model: "Section", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        
    }
    
    func selectedTableViewCell(){
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self]indexPath in
                
                // 선택한 항목의 인덱스 경로를 처리
//                let selectedModel = viewmodel.value[indexPath.row]
                // 선택한 모델을 사용하여 필요한 작업 수행
//                print("Selected Model: \(selectedModel.newsTitle)")
                let vc = NewsDetailContentViewController()
                
                vc.selectedModel = self?.viewmodel.items.value[indexPath.row]
                
                self?.navigationController?.pushViewController(vc, animated: true)
                
                
            })
            .disposed(by: disposeBag)

    }
}



//extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewmodel.title.value.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
////        cell.titleLabel.text = viewmodel.title.value[indexPath.row]
//        return cell
//    }
//    
//    
//}


//class NewsViewController: UITableViewController{
//
//    private let disposeBag = DisposeBag()
//
//    var authorArray = [String]()
//    var titleArray = [String]()
//    var descriptionArray = [String]()
//    var imgUrlArray = [String]()
//    var contentArray = [String]()
//
//    var lastContentOffset: CGFloat = 0
//
//
//
//
////    func fetchData(){
////        let url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6cadc26e16894316aff6cfde14050ba5"
////
//////        let headers: HTTPHeaders = ["accept" : "application/json"]
////        AF.request(url, method: .get, parameters: nil).validate(statusCode: 200..<300).responseDecodable(of: NewsAPI.self){ response in
////            switch response.result{
////            case.success(let datas):
////                for data in datas.articles{
////                    self.titleArray.append(data.title)
////                    self.descriptionArray.append(data.description)
////                    self.authorArray.append(data.author)
////                    self.imgUrlArray.append(data.urlToImage)
////                    self.contentArray.append(data.content ?? "Have No content")
////                }
////                self.tableView.reloadData()
////
////            case .failure(let err):
////                print("Fetch NewsAPI Data \(err.localizedDescription)")
////            }
////        }
////    }
////
////    func testRxSwiftComine(){
////        _ = rxSwiftFetchData()
////            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)) // 백그라운드 스레드에서 작업 실행
////            .observeOn(MainScheduler.instance) // UI업데이트를 메인스레드에서
////            .subscribe(onNext: { datas in
////                for data in datas.articles{
////                    self.titleArray.append(data.title)
////                    self.descriptionArray.append(data.description)
////                    self.authorArray.append(data.author)
////                    self.imgUrlArray.append(data.urlToImage)
////                    self.contentArray.append(data.content ?? "Have No content")
////                }
////                self.tableView.reloadData()
////            })
////            .disposed(by: disposeBag)
////
////    }
////
////    func rxSwiftFetchData() -> Observable<NewsAPI>{
////        let url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=6cadc26e16894316aff6cfde14050ba5"
////
////        return Observable<NewsAPI>.create(){ emitter in
////
////
////            AF.request(url, method: .get, parameters: nil).validate(statusCode: 200..<300).responseDecodable(of: NewsAPI.self){ response in
////                switch response.result{
////                case.success(let data):
////                    emitter.onNext(data)
////                    emitter.onCompleted()
////                case .failure(let err):
////                    print("Fetch NewsAPI Data \(err.localizedDescription)")
////                }
////            }
////            return Disposables.create {
////
////            }
////        }
////
////    }
//
//
//
//    let festivalNewsTitleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 30)
//        label.font = UIFont(name: "Noto Sans Myanmar", size: 30)
//        label.text = "Festival News"
//        return label
//    }()
//
//
//    let viewmodel = Viewmodel()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        fetchData()
////        testRxSwiftComine()
//        setTableView()
//
//    }
//
//    func setTableView(){
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView = UITableView(frame: view.bounds, style: .grouped)
//        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//
//
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
//
//        viewmodel.title
//            .asObservable()
//            .bind(to: tableView.rx.items(cellIdentifier: "NewsTableViewCell")) { (row, element, cell) in
//                cell.titleLabel.text = element
//            }
//            .disposed(by:)
//
//        viewmodel.reload()
////        cell.titleLabel.text = viewmodel.title.value[indexPath.row]
////
////
////        cell.authorLabel.text = viewmodel.author.value[indexPath.row]
////        cell.titleLabel.text = viewmodel.title.value[indexPath.row]
////        cell.descriptionLabel.text = "Content: \(viewmodel.description.value[indexPath.row])"
////
////
////        let imageURLStr = viewmodel.imgUrl.value[indexPath.row]
////        cell.img.kf.setImage(with: URL(string: imageURLStr))
////        tableView.reloadData()
//
////        cell.authorLabel.text = authorArray[indexPath.row]
////        cell.titleLabel.text = titleArray[indexPath.row]
////        cell.descriptionLabel.text = "Content: \(descriptionArray[indexPath.row])"
////
////
////        let imageURLStr = imgUrlArray[indexPath.row]
////        cell.img.kf.setImage(with: URL(string: imageURLStr))
//        return cell
//    }
//
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = NewsDetailContentViewController()
//        vc.imgUrl = viewmodel.imgUrl.value[indexPath.row]
//        vc.titleLabel.text = viewmodel.title.value[indexPath.row]
//        vc.bottomSheetContent = viewmodel.content.value[indexPath.row]
//        vc.bottomSheetDescription = viewmodel.description.value[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//
//    }
//
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.white
//
//        let titleLabel: UILabel = {
//           let label = UILabel()
//            label.text = "Daily News"
//            label.textColor = .darkGray
//            label.font = .boldSystemFont(ofSize: 40)
//            label.font = UIFont(name: "Noto Sans Myanmar", size: 40)
//            label.translatesAutoresizingMaskIntoConstraints = false
//            return label
//        }()
//
//        headerView.addSubview(titleLabel)
//
//        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
//
//
//        return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return view.bounds.height / 7
//    }
//
////    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
////
////        let contentOffset = scrollView.contentOffset.y
////
////
////        if contentOffset > self.lastContentOffset {
////            // 아래로 스크롤 중
////            print("아래로 스크롤 중")
////        } else if contentOffset < self.lastContentOffset {
////            // 위로 스크롤 중
////            print("위로 스크롤 중")
////        }
////
////        self.lastContentOffset = contentOffset
////    }
//}



