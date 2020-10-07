//
//  HomeVC.swift
//  CoreML in ARKit
//
//  Created by Saransh Mittal on 21/10/18.
//  Copyright © 2018 CompanyName. All rights reserved.
//

import UIKit
import Lottie

class HomeVC: UIViewController {

    @IBOutlet weak var loader: UIView!
    var animation: LOTAnimationView?
    
    func initLoader() {
        animation = LOTAnimationView(name: "data") as LOTAnimationView
        animation?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        animation?.contentMode = .scaleAspectFill
        animation?.frame = loader.bounds
        animation?.loopAnimation = true
        loader.addSubview(animation!)
    }
 
    func transitionToScanner() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! SpotlightVC
            self.present(newViewController, animated: true, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLoader()
        self.transitionToScanner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animation?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        animation?.pause()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
