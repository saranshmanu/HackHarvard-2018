//
//  ViewController.swift
//  SPOT
//
//  Created by Saransh Mittal on 20/10/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

let content = ["Doritos", "Lays", "Munch", "Parle G"]

class ViewController: UIViewController, ARSKViewDelegate,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var searchedResults:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedResults.count
    }
    
    @IBAction func addToCart(_ sender: Any) {
        let alertController = UIAlertController(title: "Success",message: "Added to cart!",preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! SearchedTableViewCell
        cell.productNameLabel.text = searchedResults[indexPath.row] as String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.resignFirstResponder()
        dismissSearch()
    }
    
    func dismissSearch(){
        productTableView.isHidden = true
        backgroundBlur.isHidden = true
        lowerButtonStack.isHidden = true
        searchLabelBelowTextField.isHidden = true
    }
    
    func returnSearch(){
        backgroundBlur.isHidden = false
        productTableView.isHidden = false
        lowerButtonStack.isHidden = false
        searchLabelBelowTextField.isHidden = false
    }
    
    func searchAndUpdate(searchedTerm:String){
        searchedResults = []
        for i in content{
            if i.lowercased().range(of:searchedTerm.lowercased()) != nil {
                searchedResults.append(i)
            }
        }
        productTableView.reloadData()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        returnSearch()
        searchAndUpdate(searchedTerm: searchTextField.text as! String)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        returnSearch()
        searchAndUpdate(searchedTerm: searchTextField.text as! String)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        returnSearch()
        let searchedTerm:String = textField.text as! String
        print(searchedTerm)
        searchAndUpdate(searchedTerm: searchedTerm)
        productTableView.reloadData()
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        searchTextField.resignFirstResponder()
    }
    
    @IBOutlet weak var searchLabelBelowTextField: UILabel!
    @IBOutlet weak var lowerButtonStack: UIStackView!
    @IBOutlet weak var backgroundBlur: UIVisualEffectView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: "What are you looking for?",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        dismissSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        let labelNode = SKLabelNode(text: "👾")
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
