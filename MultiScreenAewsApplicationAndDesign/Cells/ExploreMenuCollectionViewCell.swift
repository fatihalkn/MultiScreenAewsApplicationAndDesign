//
//  ExploreMenuCollectionViewCell.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 7.01.2024.
//

import UIKit

class ExploreMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLbl: UILabel!
    
    
static let identifier = "ExploreMenuCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(menu: MenuModel) {
        textLbl.text = menu.title
    }
}

