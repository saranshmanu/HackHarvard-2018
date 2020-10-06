//
//  CameraViewController.swift
//  CoreML in ARKit
//
//  Created by Saransh Mittal on 09/12/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision

class CameraViewController: UIViewController, ARSCNViewDelegate {
    
    var detectedObjectData = [[Bool]()]
    
    var codeOne = "Amul Kool Strawberry Shake "
    var codeTwo = "Nachos Tomato "
    var codeThree = "Parle Wafers "
    var codeFour = "Amul Milk Shake "
    var codeFive = "Kurkure Puffcorn Cheese "
    var codeSix = "TATA Gluco Lemon "
    var codeSeven = "Colgate Toothpaste "
    var codeEight = "Jaggery "
    var codeNine = "Thuthuvalai Candy "
    
    //sugar, caffiene, salt
    var oneContent = [true, false, false]
    var twoContent = [false, false, true]
    var threeContent = [false, false, true]
    var fourContent = [true, true, false]
    var fiveContent = [true, false, true]
    var sixContent = [true, true, false]
    var sevenContent = [false, false, true]
    var eightContent = [true, false, false]
    var nineContent = [false, false, false]
    
    @IBAction func sugarFreeAction(_ sender: Any) {
        print(detectedObjectCode)
        detectedObjectData = []
        for i in detectedObjectCode {
            if i == codeOne {detectedObjectData.append(oneContent)}
            else if i == codeTwo {detectedObjectData.append(twoContent)}
            else if i == codeThree {detectedObjectData.append(threeContent)}
            else if i == codeFour {detectedObjectData.append(fourContent)}
            else if i == codeFive {detectedObjectData.append(fiveContent)}
            else if i == codeSix {detectedObjectData.append(sixContent)}
            else if i == codeSeven {detectedObjectData.append(sevenContent)}
            else if i == codeEight {detectedObjectData.append(eightContent)}
            else if i == codeNine {detectedObjectData.append(nineContent)}
            else {}
        }
        
        for i in 0...detectedObjectData.count-1{
            if detectedObjectData[i][0] == true {
                changeNodeText(text: "High Sugar Content", number: i)
            } else {
                changeNodeText(text: "Sugar Free", number: i)
            }
        }
        
    }
    @IBAction func highEnergyAction(_ sender: Any) {
        detectedObjectData = []
        for i in detectedObjectCode {
            if i == codeOne {detectedObjectData.append(oneContent)}
            else if i == codeTwo {detectedObjectData.append(twoContent)}
            else if i == codeThree {detectedObjectData.append(threeContent)}
            else if i == codeFour {detectedObjectData.append(fourContent)}
            else if i == codeFive {detectedObjectData.append(fiveContent)}
            else if i == codeSix {detectedObjectData.append(sixContent)}
            else if i == codeSeven {detectedObjectData.append(sevenContent)}
            else if i == codeEight {detectedObjectData.append(eightContent)}
            else if i == codeNine {detectedObjectData.append(nineContent)}
            else {}
        }
        
        for i in 0...detectedObjectData.count-1{
            if detectedObjectData[i][2] == true {
                changeNodeText(text: "High Salt", number: i)
            } else {
                changeNodeText(text: "Low Salt", number: i)
            }
        }
    }
    @IBAction func caffieneFreeAction(_ sender: Any) {
        detectedObjectData = []
        for i in detectedObjectCode {
            if i == codeOne {detectedObjectData.append(oneContent)}
            else if i == codeTwo {detectedObjectData.append(twoContent)}
            else if i == codeThree {detectedObjectData.append(threeContent)}
            else if i == codeFour {detectedObjectData.append(fourContent)}
            else if i == codeFive {detectedObjectData.append(fiveContent)}
            else if i == codeSix {detectedObjectData.append(sixContent)}
            else if i == codeSeven {detectedObjectData.append(sevenContent)}
            else if i == codeEight {detectedObjectData.append(eightContent)}
            else if i == codeNine {detectedObjectData.append(nineContent)}
            else {}
        }
        
        for i in 0...detectedObjectData.count-1{
            if detectedObjectData[i][1] == true {
                changeNodeText(text: "Contains high caffiene content", number: i)
            } else {
                changeNodeText(text: "Low caffiene content", number: i)
            }
        }
    }
    
    func setBorderColor(yourButton: UIButton){
        yourButton.layer.borderWidth = 1
        yourButton.layer.borderColor = UIColor(red:151/255, green:33/255, blue:23/255, alpha: 1).cgColor
        yourButton.layer.cornerRadius = yourButton.frame.height / 2
    }
    
    @IBOutlet weak var sugarFree: UIButton!
    @IBOutlet weak var highEnergy: UIButton!
    @IBOutlet weak var caffieneFree: UIButton!
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var debugTextView: UITextView!
    
    let bubbleDepth : Float = 0.01 // the 'depth' of 3D text
    var latestPrediction : String = "…" // a variable containing the latest CoreML prediction
    
    var visionRequests = [VNRequest]()
    let dispatchQueueML = DispatchQueue(label: "com.hw.dispatchqueueml") // A Serial Queue

    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderColor(yourButton: sugarFree)
        setBorderColor(yourButton: highEnergy)
        setBorderColor(yourButton: caffieneFree)
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
        self.sceneView.addGestureRecognizer(tapGesture)
        // Set up Vision Model
        guard let selectedModel = try? VNCoreMLModel(for: MobileNet().model) else { // (Optional) This can be replaced with other models on https://developer.apple.com/machine-learning/
            fatalError("Could not load model. Ensure model has been drag and dropped (copied) to XCode Project from https://developer.apple.com/machine-learning/ . Also ensure the model is part of a target (see: https://stackoverflow.com/questions/45884085/model-is-not-part-of-any-target-add-the-model-to-a-target-to-enable-generation ")
        }
        // Set up Vision-CoreML Request
        let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompleteHandler)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop // Crop from centre of images and scale to appropriate size.
        visionRequests = [classificationRequest]
        // Begin Loop to Update CoreML
        loopCoreMLUpdate()
        // Do any additional setup after loading the view.
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
        var font = UIFont(name: "Montserrat", size: 0.07)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
