
//
//  FilterCollectionViewCell.swift
//  CoreML in ARKit
//
//  Created by Saransh Mittal on 20/10/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func update(filter: Filter) {
        self.image.image = UIImage.init(named: filter.image)
        self.label.text = filter.name
    }
}
