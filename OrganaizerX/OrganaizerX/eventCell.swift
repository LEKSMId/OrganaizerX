//
//  eventCell.swift
//  OrganaizerX
//
//  Created by Alex on 2/28/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class eventCell: UITableViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(image: UIImage, text: String, date: String) {
        
        mainImg.image = image
        mainLbl.text = text
        dateLbl.text = date
    }
    
}
