//
//  CarDetailView.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit

class CarDetailView: NibDefinedView, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func config(_ item: CarDetailViewModel) {
        titleLabel.text = item.getName()
        descriptionLabel.text = item.getDescription()
        imageView.image = item.getImage()
    }
}
