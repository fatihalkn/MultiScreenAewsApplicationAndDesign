//
//  ViewController.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    
    var menuCollectionViewData: [MenuModel] = [
        .init(type: .tech, title: "Tech"),
        .init(type: .science, title: "Science"),
        .init(type: .education, title: "Education"),
        .init(type: .business, title: "Business")
    ]
    
    var feedCollectionViewItemsData = [Model]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerReusableViews()
        setupDelegates()
        
        ApıCaller.shared.getTopStories  { [weak self] result in
            switch result {
                
            case .success(let articles):
                self?.feedCollectionViewItemsData = articles.compactMap({
                    Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date", description: $0.description, content: $0.content)
                    
                })
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.feedCollectionView.reloadData()
            }
            
        }
    }
    


    
    
    
    
    func registerReusableViews() {
        menuCollectionView.register(UINib(nibName: MenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        feedCollectionView.register(UINib(nibName: FeedCollectionViewHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FeedCollectionViewHeader.identifier)
        feedCollectionView.register(UINib(nibName: FeedCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
    }
    
    func setupDelegates() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
    }
    
    
    
}

//MARK: - Configure CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,UISearchBarDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            switch collectionView {
            case menuCollectionView:
                return .init()
            case feedCollectionView:
                let header = feedCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FeedCollectionViewHeader.identifier, for: indexPath) as! FeedCollectionViewHeader
                header.setup(datas: feedCollectionViewItemsData)
                return header
            default:
                return .init()
            }
            
        case UICollectionView.elementKindSectionFooter:
            return .init()
        default:
            return .init()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch collectionView {
        case menuCollectionView:
            return .init()
        case feedCollectionView:
            let headerWidth: CGFloat = collectionView.frame.width
            let headerHeight: CGFloat = collectionView.frame.height / 4
            
            return CGSize(width: headerWidth, height: headerHeight)
        default:
            return .init()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case menuCollectionView:
            return menuCollectionViewData.count
        case feedCollectionView:
            return feedCollectionViewItemsData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case menuCollectionView:
            let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            
            let menu = menuCollectionViewData[indexPath.item]
            cell.setup(menu: menu)
            
            return cell
        case feedCollectionView:
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
            cell.configure(with: feedCollectionViewItemsData[indexPath.item])
            return cell
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case menuCollectionView:
            collectionView.deselectItem(at: indexPath, animated: true)
            let selectedMenuType = menuCollectionViewData[indexPath.item].type
            ApıCaller.shared.fetchNewsByCategory(category: selectedMenuType) { result in
                switch result {
                case .success(let articles):
                    self.feedCollectionViewItemsData = articles.compactMap({
                        Model(title: $0.title ?? "", subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date", description: $0.description, content: $0.content)
                        
                    })
                    DispatchQueue.main.async {
                        self.feedCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        case feedCollectionView:
            feedCollectionView.deselectItem(at: indexPath, animated: true)
            let controller = InfoController.instantiate()
            controller.model = collectionView == feedCollectionView ?
            feedCollectionViewItemsData[indexPath.item]:Model(title: "Default Title", subtitle: "Default Subtitle", imageURL: nil, imageData: nil, publishedAt: "Default Date", description: description, content: "content")
                                    
            navigationController?.pushViewController(controller, animated: true)

        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case menuCollectionView:
            let cellWidth: CGFloat = (collectionView.frame.width - 30) / 4
            let cellHeight: CGFloat = collectionView.frame.height
            return CGSize(width: cellWidth, height: cellHeight)
        case feedCollectionView:
            let cellWidth: CGFloat = collectionView.frame.width - 40
            let cellHeight: CGFloat = 180
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .init()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            
            ApıCaller.shared.getTopStories  { [weak self] result in
                switch result {
                    
                case .success(let articles):
                    self?.feedCollectionViewItemsData = articles.compactMap({
                        Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date", description: $0.description, content: $0.content)
                    })
                case .failure(let error):
                    print(error)
                }
                DispatchQueue.main.async {
                    self?.feedCollectionView.reloadData()
                }
                
            }
        }
            filterContentForSearchText(searchText)
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            searchBar.text = ""
            searchBar.resignFirstResponder()
            filterContentForSearchText("")
            
            
            
            
            
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }

        func filterContentForSearchText(_ searchText: String) {
            // Arama kriterlerine göre koleksiyonu filtrele
            let filteredData = feedCollectionViewItemsData.filter { model in
                return model.title.lowercased().contains(searchText.lowercased())
            }

            // Filtrelenmiş verileri kullanarak collectionView'ı güncelle
            feedCollectionViewItemsData = searchText.isEmpty ? feedCollectionViewItemsData : filteredData
            DispatchQueue.main.async {
                self.feedCollectionView.reloadData()
            }
            
            
            
            
        }
    }
    

