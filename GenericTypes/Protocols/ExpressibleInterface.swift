//
//  ExpressibleInterface.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

protocol ExpressibleInterface {}
extension ExpressibleInterface {
    func populate<C>(configurable: C) -> C where C: ConfigurableView, C.Item == Self {
        configurable.config(self)
        return configurable
    }
}
