//
//  CarCollectionViewCell.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet weak var carView: CarView!
    
    func config(_ item: CarViewModel) {
        carView.config(item)
    }
}
