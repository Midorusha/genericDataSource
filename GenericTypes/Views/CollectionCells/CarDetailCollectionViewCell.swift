//
//  CarDetailCollectionViewCell.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class CarDetailCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet weak var carDetailView: CarDetailView!
    
    func config(_ item: CarDetailViewModel) {
        carDetailView.config(item)
    }
}
