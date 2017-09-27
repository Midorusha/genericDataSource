//
//  ConfigurableView.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

protocol ConfigurableView {
    associatedtype Item
    func config(_ item: Item)
}
