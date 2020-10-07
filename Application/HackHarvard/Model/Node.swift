//
//  Node.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision
import Lottie

class Node {
    var placementLabel: String?
    var SCNNode: SCNNode?
    var MLPrediction: String?
    var product: Product?
    
    init(SCNNode: SCNNode, MLPrediction: String, placementLabel: String, product: Product) {
        self.SCNNode = SCNNode
        self.MLPrediction = MLPrediction
        self.placementLabel = placementLabel
        self.product = product
    }
}
