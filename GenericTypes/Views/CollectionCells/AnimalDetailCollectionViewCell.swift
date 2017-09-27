//
//  AnimalDetailCollectionViewCell.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class AnimalDetailCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet weak var animalView: AnimalView!
    
    func config(_ item: AnimalViewModel) {
        animalView.config(item)
    }
}
