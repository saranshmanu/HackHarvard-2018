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
            let ARcoordinates: matrix_float4x4 = closestResult.worldTransform
            let SCNCoordinates: SCNVector3 = SCNVector3Make(ARcoordinates.columns.3.x, ARcoordinates.columns.3.y, ARcoordinates.columns.3.z)
            let SCNPoint: SCNNode = createNewBubbleParentNode(prediction)
            SCNPoint.position = SCNCoordinates
            SCNNodes.append(Node(SCNNode: SCNPoint, MLPrediction: prediction, placementLabel: prediction))
            sceneView.scene.rootNode.addChildNode(SCNPoint)
            
        }
    }
    
    func createNewBubbleParentNode(_ text : String) -> SCNNode {
        let bubbleDepth : Float = 0.01
        // Create a SCNSphere
        let SCNNodeSphere = SCNSphere(radius: 0.004)
        SCNNodeSphere.firstMaterial?.diffuse.contents = UIColor.cyan
        let SCNPointSphere = SCNNode(geometry: SCNNodeSphere)
        // Create a SCNText
        let SCNNodeText = SCNText(string: text, extrusionDepth: CGFloat(bubbleDepth))
        var font = UIFont(name: "Montserrat", size: 0.20)
        font = font?.withTraits(traits: .traitBold)
        SCNNodeText.font = font
        SCNNodeText.alignmentMode = kCAAlignmentCenter
        SCNNodeText.firstMaterial?.diffuse.contents = UIColor.white
        SCNNodeText.firstMaterial?.specular.contents = UIColor.white
        SCNNodeText.firstMaterial?.isDoubleSided = true
        SCNNodeText.chamferRadius = CGFloat(bubbleDepth)
        let (minBound, maxBound) = SCNNodeText.boundingBox
        let SCNPointText = SCNNode(geometry: SCNNodeText)
        SCNPointText.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        SCNPointText.scale = SCNVector3Make(0.2, 0.2, -0.2)
        // Create a Parent Node
        let constraints = SCNBillboardConstraint()
        constraints.freeAxes = SCNBillboardAxis.Y
        let SCNParentNode = SCNNode()
        SCNParentNode.addChildNode(SCNPointText)
        SCNParentNode.addChildNode(SCNPointSphere)
        SCNParentNode.constraints = [constraints]
        return SCNParentNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            // Do any desired updates to SceneKit here.
        }
    }
}
