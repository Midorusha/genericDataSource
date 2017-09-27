//
//  ViewModel.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype DataType
    var data: DataType { get set }
    init(data: DataType)
}
