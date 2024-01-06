//
//  FeedCollectionViewHeaderCell.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import UIKit

class FeedCollectionViewHeaderCell: UICollectionViewCell {
static let identifier = "FeedCollectionViewHeaderCell"
    

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsExplanation: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
        
        
    }

}
