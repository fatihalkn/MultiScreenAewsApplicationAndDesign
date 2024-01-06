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
    var headerCollectionViewData: [String] = [
        "1213",
        "2313",
        "2131"
    ]
    
    var currentPage = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
        setupDelegates()
    }
    
    func registerCells() {
        headerCollectionView.register(UINib(nibName: FeedCollectionViewHeaderCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewHeaderCell.identifier)
    }
    
    func setupDelegates() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
    }
    
}

//MARK: - Configure CollectionView
extension FeedCollectionViewHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerCollectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewHeaderCell.identifier, for: indexPath) as! FeedCollectionViewHeaderCell
        
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

