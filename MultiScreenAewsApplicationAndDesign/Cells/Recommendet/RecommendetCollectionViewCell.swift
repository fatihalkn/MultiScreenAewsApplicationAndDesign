//
//  RecommendetCollectionViewCell.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 7.01.2024.
//

import UIKit

class RecommendetCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var historyLbl: UILabel!
    
    static let identifier = "RecommendetCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func configure(with viewModel: Model) {
        titleLbl.text = viewModel.subtitle
        textLbl.text = viewModel.title
        historyLbl.text = viewModel.publishedAt
        
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        } else  if let url = viewModel.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
            
            
        }
    }
}
