//
//  SpotlightViewController.swift
//  CoreML in ARKit
//
//  Created by Saransh Mittal on 21/10/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//

import UIKit
import Lottie

class SpotlightViewController: UIViewController {

    @IBOutlet weak var loader: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! ViewController
            self.present(newViewController, animated: true, completion: nil)
        })
        
        var boatAnimation: LOTAnimationView?
        boatAnimation = LOTAnimationView(name: "data")
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleAspectFill
        boatAnimation!.frame = loader.bounds
        loader.addSubview(boatAnimation!)
        boatAnimation!.loopAnimation = true
        boatAnimation?.play()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
