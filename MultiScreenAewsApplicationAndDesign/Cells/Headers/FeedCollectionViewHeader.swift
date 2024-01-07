//
//  FeedCollectionViewHeader.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import UIKit

class FeedCollectionViewHeader: UICollectionReusableView {
static let identifier = "FeedCollectionViewHeader"
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    var headerCollectionViewData = [Model]()
    
    var currentPage = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
        setupDelegates()
        
//        ApıCaller.shared.getTopStories  { [weak self] result in
//            switch result {
//                
//            case .success(let articles):
//                self?.headerCollectionViewData = articles.compactMap({
//                    Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date")
//                    
//                })
//            case .failure(let error):
//                print(error)
//            }
//            DispatchQueue.main.async {
//                self?.headerCollectionView.reloadData()
//            }
//            
//        }

    }
    
    func registerCells() {
        headerCollectionView.register(UINib(nibName: FeedCollectionViewHeaderCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewHeaderCell.identifier)
    }
    
    func setupDelegates() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
    }
    
    func setup(datas: [Model]) {
        self.headerCollectionViewData = datas
        DispatchQueue.main.async {
            self.headerCollectionView.reloadData()
        }
    }
    
}

//MARK: - Configure CollectionView
extension FeedCollectionViewHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerCollectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewHeaderCell.identifier, for: indexPath) as! FeedCollectionViewHeaderCell
        let model = headerCollectionViewData[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHeight: CGFloat = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageController.currentPage = currentPage 
    }
    
    
}

