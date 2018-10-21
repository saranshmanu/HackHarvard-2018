//
//  MoreInformationViewController.swift
//  SPOT
//
//  Created by Saransh Mittal on 20/10/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class MoreInformationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = alternativesCollectionView.dequeueReusableCell(withReuseIdentifier: "alternative", for: indexPath)
        return cell
    }
    

    @IBOutlet weak var alternativesCollectionView: UICollectionView!
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        alternativesCollectionView.dataSource = self
        alternativesCollectionView.delegate = self
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
