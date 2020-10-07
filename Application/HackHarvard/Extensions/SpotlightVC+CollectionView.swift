//
//  SpotlightVC+CollectionView.swift
//  HackHarvard
//
//  Created by Saransh Mittal on 07/10/20.
//  Copyright © 2020 CompanyName. All rights reserved.
//

import Foundation
import UIKit

// CollectionView
extension SpotlightVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func initCollectionView() {
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filter", for: indexPath) as! FilterCollectionViewCell
        cell.update(filter: filters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // update the selected filter
    }
}
