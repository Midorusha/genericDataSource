//
//  AnimalCollectionViewCell.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class AnimalCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    func config(_ item: AnimalViewModel) {
        titleLabel.text = item.getName()
        subtitleLabel.text = item.getDescription()
    }
}
