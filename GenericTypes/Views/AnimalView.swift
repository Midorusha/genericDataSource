//
//  AnimalView.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class AnimalView: NibDefinedView, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    func config(_ item: AnimalViewModel) {
        titleLabel.text = item.getName()
        descriptionLabel.text = item.getDescription()
        weightLabel.text = item.getWeight()
    }
}
