//
//  AnimalViewModel.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class AnimalViewModel: ViewModel {
    internal var data: Animal
    
    required init(data: Animal) {
        self.data = data
    }
    
    public func getName() -> String {
        return data.name
    }
    
    public func getDescription() -> String {
        return data.description
    }
    
    public func getWeight() -> String {
        return "\(data.weight)lbs"
    }
}

extension AnimalViewModel: ExpressedAsView {
    typealias ViewType = AnimalView
}

extension AnimalViewModel: ExpressedCollectionViewCellType {
    typealias CollectionCellType = AnimalCollectionViewCell
    var collectionViewCellSize: CGSize? {
        return .init(width: 100, height: 100)
    }
}
