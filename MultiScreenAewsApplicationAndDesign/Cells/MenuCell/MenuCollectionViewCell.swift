//
//  MenuCollectionViewCell.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
    
    @IBOutlet weak var menuTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(menu: MenuModel) {
        menuTextLbl.text = menu.title
    }
}
