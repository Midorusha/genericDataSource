//
//  Car.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

enum ImageEnum {
    case one
    case two
    case three
}

struct Car {
    var name: String
    var description: String
    var imageEnum: ImageEnum
}
