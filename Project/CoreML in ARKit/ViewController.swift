//
//  ViewController.swift
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

let filterNames = ["CAFFEINE","DAIRY FREE","EGG FREE","LESS FAT","GLUTEN FREE","NUT FREE","SOY FREE","SUGAR FREE"]
let filterPositive = ["Least Caffeine Content","Dairy Free","Egg Free","Least Fat content","Gluten Free","Nut Free","Soy Free","Sugar Free"]
let filterImages = ["Caffeine","DairyFree","EggFree","FatFree","GlutenFree","NutFree","SoyFree","SugarFree"]
let filterNegative = ["Contains Caffeine","Contains Dairy","Contains Egg","Contains Fat","Contains Gluten","Contains Nut","Contains Soy","Contains Sugar"]

var bananaCode = "Banana "
var cafeMochaCode = "Cafe Mocha "
var muffinCode = "Muffin "
var CocaColaCode = "CocaCola "
var MandMCode = "M&M "
var YogurtCode = "Yogurt "

var detectedObjectCode = [String]()
var detectedObjectData = [food]()

var totalLength = 0
var H = [Int]()
var previousSelected = 0

class ViewController: UIViewController, ARSCNViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var scannerAnimation: UIView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filter", for: indexPath) as! FilterCollectionViewCell
        cell.imageView.image = UIImage.init(named: filterImages[indexPath.row])
        cell.filterLabel.text = filterNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detectedObjectData = []
        for i in detectedObjectCode {
            if i == bananaCode {detectedObjectData.append(bananaContents)}
            else if i == cafeMochaCode {detectedObjectData.append(CafeMochaContents)}
            else if i == YogurtCode {detectedObjectData.append(YogurtContents)}
            else if i == muffinCode {detectedObjectData.append(muffinContents)}
            else if i == MandMCode {detectedObjectData.append(MandMContents)}
            else if i == CocaColaCode {detectedObjectData.append(CocaColaContents)}
            else {}
        }

        if indexPath.row == 0 {
            for i in 0...detectedObjectData.count-1{
                changeNodeText(text: String(detectedObjectData[i].caffeineContent) + " units Caffeine", number: i)
            }
        } else if indexPath.row == 1 {
            for i in 0...detectedObjectData.count-1{
                if detectedObjectData[i].dairyFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        } else if indexPath.row == 2 {
            for i in 0...detectedObjectData.count-1{
                if detectedObjectData[i].eggFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        } else if indexPath.row == 3 {
            for i in 0...detectedObjectData.count-1{
                changeNodeText(text: String(detectedObjectData[i].fatContent) + " units Fat", number: i)
            }
        } else if indexPath.row == 4 {
            for i in 0...detectedObjectData.count-1{
                if detectedObjectData[i].glutenFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        } else if indexPath.row == 5 {
            for i in 0...detectedObjectData.count-1{
                if detectedObjectData[i].nutsFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        } else if indexPath.row == 6 {
            for i in 0...detectedObjectData.count-1{
                changeNodeText(text: "No information available", number: i)
//                if detectedObjectData[i].soyFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
//                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        } else if indexPath.row == 7 {
            for i in 0...detectedObjectData.count-1{
                if detectedObjectData[i].sugarFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        } else {
            for i in 0...detectedObjectData.count-1{
                if detectedObjectData[i].dairyFree == true {selectedPinNode(number: i, filter:filterPositive[indexPath.row])}
                else {deselectPinNode(number: i, filter:filterNegative[indexPath.row])}
            }
        }
        
//        H.removeAll()
//        let number = Int.random(in: 0 ..< totalLength)
//        previousSelected = number
//        for i in 0...(totalLength - 1) {
//            if i == number {
//                H.append(1)
//            } else {
//                H.append(0)
//            }
//        }
//        for i in 0...(H.count-1) {
//            if H[i] == 0{
//                deselectPinNode(number: i, filter:filterPositive[indexPath.row])
//            } else {
//                selectedPinNode(number: i, filter:filterNegative[indexPath.row])
//            }
//        }
    }
    
    func changeNodeText(text:String, number:Int){
        NODES[number].removeFromParentNode()
        NODES.remove(at: number)
        var closestResult = closestRESULT[number]
        let transform : matrix_float4x4 = closestResult.worldTransform
        let worldCoord : SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        let node : SCNNode = createNewBubbleParentNode(text)
        sceneView.scene.rootNode.addChildNode(node)
        node.position = worldCoord
        NODES.insert(node, at: number)
    }
    
    func selectedPinNode(number:Int, filter:String) {
        changeNodeText(text: filter, number: number)
    }
    
    func deselectPinNode(number:Int, filter:String) {
        changeNodeText(text: filter, number: number)
    }
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        boatAnimation = LOTAnimationView(name: "barcode_scanner")
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleAspectFill
        boatAnimation!.frame = scannerAnimation.bounds
        scannerAnimation.addSubview(boatAnimation!)
        boatAnimation!.loopAnimation = true
        boatAnimation?.play()
    }
    
    var boatAnimation: LOTAnimationView?
    @IBOutlet var sceneView: ARSCNView!
    let bubbleDepth : Float = 0.01 // the 'depth' of 3D text
    var latestPrediction : String = "…" // a variable containing the latest CoreML prediction
    
    var visionRequests = [VNRequest]()
    let dispatchQueueML = DispatchQueue(label: "com.hw.dispatchqueueml") // A Serial Queue
    @IBOutlet weak var debugTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Create a new scene
        let scene = SCNScene()
        // Set the scene to the view
        sceneView.scene = scene
        // Enable Default Lighting - makes the 3D text a bit poppier.
        sceneView.autoenablesDefaultLighting = true
        // Tap Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognize:)))
        self.scannerAnimation.addGestureRecognizer(tapGesture)
        // Set up Vision Model
        guard let selectedModel = try? VNCoreMLModel(for: MODEL().model) else { // (Optional) This can be replaced with other models on https://developer.apple.com/machine-learning/
            fatalError("Could not load model. Ensure model has been drag and dropped (copied) to XCode Project from https://developer.apple.com/machine-learning/ . Also ensure the model is part of a target (see: https://stackoverflow.com/questions/45884085/model-is-not-part-of-any-target-add-the-model-to-a-target-to-enable-generation ")
        }
        // Set up Vision-CoreML Request
        let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompleteHandler)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop // Crop from centre of images and scale to appropriate size.
        visionRequests = [classificationRequest]
        // Begin Loop to Update CoreML
        loopCoreMLUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // Enable plane detection
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            // Do any desired updates to SceneKit here.
        }
    }
    
    // MARK: - Status Bar: Hide
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    var NODES = [SCNNode]()
    var closestRESULT = [ARHitTestResult]()
    
    @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {
        // HIT TEST : REAL WORLD
        // Get Screen Centre
        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        let arHitTestResults : [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [.featurePoint]) // Alternatively, we could use '.existingPlaneUsingExtent' for more grounded hit-test-points.
//        print(arHitTestResults)
        if let closestResult = arHitTestResults.first {
            // Get Coordinates of HitTest
            let transform : matrix_float4x4 = closestResult.worldTransform
            let worldCoord : SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            // Create 3D Text
            let node : SCNNode = createNewBubbleParentNode(latestPrediction)
            sceneView.scene.rootNode.addChildNode(node)
            node.position = worldCoord
            NODES.append(node)
            detectedObjectCode.append(latestPrediction)
            closestRESULT.append(closestResult)
            totalLength = NODES.count
        }
    }
    
    func createNewBubbleParentNode(_ text : String) -> SCNNode {
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        let bubble = SCNText(string: text, extrusionDepth: CGFloat(bubbleDepth))
        var font = UIFont(name: "Montserrat", size: 0.20)
        font = font?.withTraits(traits: .traitBold)
        bubble.font = font
        bubble.alignmentMode = kCAAlignmentCenter
        bubble.firstMaterial?.diffuse.contents = UIColor.white
        bubble.firstMaterial?.specular.contents = UIColor.white
        bubble.firstMaterial?.isDoubleSided = true
        bubble.chamferRadius = CGFloat(bubbleDepth)
        let (minBound, maxBound) = bubble.boundingBox
        
        let bubbleNode = SCNNode(geometry: bubble)
        bubbleNode.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, bubbleDepth/2)
        bubbleNode.scale = SCNVector3Make(0.2, 0.2, -0.2)
        let sphere = SCNSphere(radius: 0.004)
        sphere.firstMaterial?.diffuse.contents = UIColor.cyan
        let sphereNode = SCNNode(geometry: sphere)
        
        let bubbleNodeParent = SCNNode()
        bubbleNodeParent.addChildNode(bubbleNode)
        bubbleNodeParent.addChildNode(sphereNode)
        bubbleNodeParent.constraints = [billboardConstraint]
        return bubbleNodeParent
    }
    
    func loopCoreMLUpdate() {
        // Continuously run CoreML whenever it's ready. (Preventing 'hiccups' in Frame Rate)
        dispatchQueueML.async {
            // 1. Run Update.
            self.updateCoreML()
            // 2. Loop this function.
            self.loopCoreMLUpdate()
        }
    }
    
    func classificationCompleteHandler(request: VNRequest, error: Error?) {
        // Catch Errors
        if error != nil {
            print("Error: " + (error?.localizedDescription)!)
            return
        }
        guard let observations = request.results else {
            print("No results")
            return
        }
        
        // Get Classifications
        let classifications = observations[0...1] // top 2 results
            .flatMap({ $0 as? VNClassificationObservation })
            .map({ "\($0.identifier) \(String(format:"- %.2f", $0.confidence))" })
            .joined(separator: "\n")
        
        
        DispatchQueue.main.async {
            // Print Classifications
//            print(classifications)
//            print("--")
            
            // Display Debug Text on screen
            var debugText:String = ""
            debugText += classifications
            self.debugTextView.text = debugText
            
            // Store the latest prediction
            var objectName:String = "…"
            objectName = classifications.components(separatedBy: "-")[0]
            objectName = objectName.components(separatedBy: ",")[0]
            self.latestPrediction = objectName
            
        }
    }
    
    func updateCoreML() {
        ///////////////////////////
        // Get Camera Image as RGB
        let pixbuff : CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixbuff == nil { return }
        let ciImage = CIImage(cvPixelBuffer: pixbuff!)
        // Note: Not entirely sure if the ciImage is being interpreted as RGB, but for now it works with the Inception model.
        // Note2: Also uncertain if the pixelBuffer should be rotated before handing off to Vision (VNImageRequestHandler) - regardless, for now, it still works well with the Inception model.
        
        ///////////////////////////
        // Prepare CoreML/Vision Request
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        // let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage!, orientation: myOrientation, options: [:]) // Alternatively; we can convert the above to an RGB CGImage and use that. Also UIInterfaceOrientation can inform orientation values.
        
        ///////////////////////////
        // Run Image Request
        do {
            try imageRequestHandler.perform(self.visionRequests)
        } catch {
            print(error)
        }
        
    }
}

extension UIFont {
    // Based on: https://stackoverflow.com/questions/4713236/how-do-i-set-bold-and-italic-on-uilabel-of-iphone-ipad
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
}
