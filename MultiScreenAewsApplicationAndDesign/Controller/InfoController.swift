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
        feedDetail()

        
    }
    
    func feedDetail() {
       titleLbl.text = model.title
       textLbl.text = model.subtitle
       descLbl.text = model.subtitle
       historyLbl.text = model.publishedAt
       detailLbl.text = model.subtitle
       
       
   }
    
}
