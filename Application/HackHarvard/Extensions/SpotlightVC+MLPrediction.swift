//
//  SpotlightVC+MLPrediction.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import CoreML
import Vision
import UIKit

// MLKit
extension SpotlightVC {
    func initMLPredictions() {
        guard let model = try? VNCoreMLModel(for: MobileNet().model) else { return }
        let classificationRequest = VNCoreMLRequest(model: model, completionHandler: classificationCompleteHandler)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop
        visionRequests = [ classificationRequest ]
        loopCoreMLUpdate()
    }
    
    func classificationCompleteHandler(request: VNRequest, error: Error?) {
        if error != nil {
            print("Error: " + (error?.localizedDescription)!)
            return
        }
        if let observations = request.results {
            // top two ML predictions from ML Kit
            let classifications = observations[0...1]
                .compactMap({ $0 as? VNClassificationObservation })
                .map({ "\($0.identifier) \(String(format:"- %.2f", $0.confidence))" })
                .joined(separator: "\n")
            DispatchQueue.main.async {
                // Display Debug Text on screen
                self.debugTextView.text = classifications
                // Store the latest prediction
                var objectName: String = "…"
                objectName = classifications.components(separatedBy: "-")[0]
                objectName = objectName.components(separatedBy: ",")[0]
                self.prediction = objectName
                
            }
        } else { // no ML prediction results
        }
    }
    
    func getProductFromPrediction(prediction: String) -> Product {
        // search for product from prediction text from the available list in products
        return products[0]
    }
    
    func loopCoreMLUpdate() {
        // Continuously run CoreML whenever it's ready. (Preventing 'hiccups' in Frame Rate)
        // 1. Loop this function.
        // 2. Run Update.
        DispatchQueue(label: "com.hw.dispatchqueueml").async {
            // image from the sceneView
            if let predictionRGBImage = self.sceneView.session.currentFrame?.capturedImage {
                let predictionCIImage = CIImage(cvPixelBuffer: predictionRGBImage)
                let imageRequestHandler = VNImageRequestHandler(ciImage: predictionCIImage, options: [:])
                do { try imageRequestHandler.perform(self.visionRequests) } catch { print(error) }
            }
            // continue the prediction loop
            self.loopCoreMLUpdate()
        }
    }
}
