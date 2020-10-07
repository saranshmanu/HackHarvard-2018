//
//  Fonts.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import UIKit

extension UIFont {
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
}
