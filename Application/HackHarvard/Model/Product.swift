//
//  Product.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import Foundation

class Product {
    var name: String = ""
    var code: String = ""
    var dairyFree: Bool = false
    var eggFree: Bool = false
    var glutenFree: Bool = false
    var sugarFree: Bool = false
    var caffeineContent: Int = 0
    var nutsFree: Bool = false
    var soyFree: Bool = false
    var fatContent: Int = 0
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}
