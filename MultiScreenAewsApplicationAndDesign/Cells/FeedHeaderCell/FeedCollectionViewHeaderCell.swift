//
//  FeedCollectionViewHeaderCell.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import UIKit

class FeedCollectionViewHeaderCell: UICollectionViewCell {
static let identifier = "FeedCollectionViewHeaderCell"
    
    var feedColletionViewHeaderData = [Model]()
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsExplanation: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        
    }
    
    
    func configure(with viewHeader: Model) {
        newsExplanation.text = viewHeader.title
        newsTitle.text = viewHeader.publishedAt
        
        if let data = viewHeader.imageData {
            newsImageView.image = UIImage(data: data)
        } else  if let url = viewHeader.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewHeader.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
            
        }
    }
    


}
