//
//  SpotlightVC.swift
//  CoreML in ARKit
//
//  Created by Hanley Weng on 14/7/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision
import Lottie

class SpotlightVC: UIViewController {
    
    @IBOutlet weak var scannerAnimation: UIView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var debugTextView: UITextView!
    
    var SCNNodes = [Node]()
    var prediction: String = "…"
    var visionRequests = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCollectionView()
        self.initSceneView()
        self.initMLPredictions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.initScanAnimation()
    }
    
//    func changeNodeText(text:String, number:Int) {
//        SCNWorldNodes[number].removeFromParentNode()
//        SCNWorldNodes.remove(at: number)
//        var closestResult = closestRESULT[number]
//        let transform : matrix_float4x4 = closestResult.worldTransform
//        let worldCoord : SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
//        let node : SCNNode = createNewBubbleParentNode(text)
//        sceneView.scene.rootNode.addChildNode(node)
//        node.position = worldCoord
//        SCNWorldNodes.insert(node, at: number)
//    }
    
    var animation: LOTAnimationView?
    func initScanAnimation() {
        animation = LOTAnimationView(name: "barcode_scanner")
        animation?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        animation?.contentMode = .scaleAspectFill
        animation?.frame = scannerAnimation.bounds
        animation?.loopAnimation = true
        scannerAnimation.addSubview(animation!)
        animation?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animation?.pause()
        scannerAnimation.willRemoveSubview(animation!)
        sceneView.session.pause()
    }
}
