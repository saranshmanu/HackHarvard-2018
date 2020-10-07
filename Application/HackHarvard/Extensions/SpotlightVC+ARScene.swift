//
//  SpotlightVC+ARScene.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision

// ARKit
extension SpotlightVC: ARSCNViewDelegate {
    func initSceneView() {
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        self.scannerAnimation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognize:))))
    }
    
    @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {
        let screenCentre: CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        let ARResults: [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [ .featurePoint ])
        if let closestResult = ARResults.first {
            let ARCoordinates: matrix_float4x4 = closestResult.worldTransform
            let SCNCoordinates: SCNVector3 = SCNVector3Make(ARCoordinates.columns.3.x, ARCoordinates.columns.3.y, ARCoordinates.columns.3.z)
            let SCNPoint: SCNNode = getParentNode(prediction)
            SCNPoint.position = SCNCoordinates
            SCNNodes.append(Node(SCNNode: SCNPoint, MLPrediction: prediction, placementLabel: prediction, product: self.getProductFromPrediction(prediction: prediction)))
            sceneView.scene.rootNode.addChildNode(SCNPoint)
            
        }
    }
    
    func getSCNTextNode(text: String) -> SCNNode {
        let bubbleDepth : Float = 0.01
        let SCNTextNode = SCNText(string: text, extrusionDepth: CGFloat(bubbleDepth))
        var font = UIFont(name: "Montserrat", size: 0.20)
        font = font?.withTraits(traits: .traitBold)
        SCNTextNode.font = font
        SCNTextNode.alignmentMode = kCAAlignmentCenter
        SCNTextNode.firstMaterial?.diffuse.contents = UIColor.white
        SCNTextNode.firstMaterial?.specular.contents = UIColor.white
        SCNTextNode.firstMaterial?.isDoubleSided = true
        SCNTextNode.chamferRadius = CGFloat(bubbleDepth)
        let (minBound, maxBound) = SCNTextNode.boundingBox
        let SCNPointText = SCNNode(geometry: SCNTextNode)
        SCNPointText.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        SCNPointText.scale = SCNVector3Make(0.2, 0.2, -0.2)
        return SCNPointText
    }
    
    func getParentNode(_ text : String) -> SCNNode {
        // Create a SCNSphere
        let SCNSphereNode = SCNSphere(radius: 0.004)
        SCNSphereNode.firstMaterial?.diffuse.contents = UIColor.cyan
        let SCNPointSphere = SCNNode(geometry: SCNSphereNode)
        // Create a Parent Node
        let constraints = SCNBillboardConstraint()
        constraints.freeAxes = SCNBillboardAxis.Y
        let SCNParentNode = SCNNode()
        SCNParentNode.addChildNode(SCNPointSphere)
        SCNParentNode.addChildNode(self.getSCNTextNode(text: text))
        SCNParentNode.constraints = [constraints]
        return SCNParentNode
    }
    
    func updateNodes(type: Filter) {
        for SCNNode in SCNNodes {
            let SCNParentNode = SCNNode.SCNNode
            let SCNChildNodes = SCNParentNode?.childNodes as [SCNNode]
            _ = SCNChildNodes[0] as SCNNode
            let SCNTextNode = SCNChildNodes[1] as SCNNode
            var placementText = ""
            let product = SCNNode.product
            switch type.name {
                case "CAFFEINE": if product?.caffeineContent == 0 { placementText = type.positive } else { placementText = type.negative }
                case "DAIRY FREE": if product?.dairyFree == false { placementText = type.positive } else { placementText = type.negative }
                case "EGG FREE": if product?.eggFree == false { placementText = type.positive } else { placementText = type.negative }
                case "LESS FAT": if product?.fatContent == 0 { placementText = type.positive } else { placementText = type.negative }
                case "GLUTEN FREE": if product?.glutenFree == false { placementText = type.positive } else { placementText = type.negative }
                case "NUT FREE": if product?.nutsFree == false { placementText = type.positive } else { placementText = type.negative }
                case "SOY FREE": if product?.soyFree == false { placementText = type.positive } else { placementText = type.negative }
                case "SUGAR FREE": if product?.sugarFree == false { placementText = type.positive } else { placementText = type.negative }
                default: return
            }
            SCNTextNode.removeFromParentNode()
            SCNParentNode?.addChildNode(self.getSCNTextNode(text: placementText))
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            // Do any desired updates to SceneKit here.
        }
    }
}
