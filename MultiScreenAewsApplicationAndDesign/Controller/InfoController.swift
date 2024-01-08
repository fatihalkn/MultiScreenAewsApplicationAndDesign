//
//  SaveController.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import UIKit

class InfoController: UIViewController {
    @IBOutlet weak var infoİmageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var historyLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: model)

        
    }
    
    func configure(with model: Model) {
        titleLbl.text = model.title
        textLbl.text = model.subtitle
        descLbl.text = model.subtitle
        historyLbl.text = model.publishedAt
        detailLbl.text = model.content
        
        if let data = model.imageData {
            infoİmageView.image = UIImage(data: data)
        } else  if let url = model.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.infoİmageView.image = UIImage(data: data)
                }
            }.resume()
            
            
        }
    }
    
    
    
    
    
    
}
