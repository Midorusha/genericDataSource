//
//  ExpressedAsView.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

protocol ExpressedAsView: ExpressibleInterface {
    associatedtype ViewType: UIView, ConfigurableView
}
