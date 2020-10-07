//
//  Filter.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import Foundation

class Filter {
    var name: String = ""
    var image: String = ""
    var positive: String = ""
    var negative: String = ""
    
    init(name: String, image: String, positive: String, negative: String) {
        self.name = name
        self.image = image
        self.positive = positive
        self.negative = negative
    }
}
