//
//  CarViewModel.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

extension CarViewModel: ExpressedAsView, ExpressedCollectionViewCellType {}
class CarViewModel: ViewModel {
    typealias ViewType = CarView
    typealias CollectionCellType = CarCollectionViewCell

    var data: Car
    
    required init(data: Car) {
        self.data = data
    }

    var collectionViewCellSize: CGSize? {
        return .init(width: 70, height: 70)
    }
}

extension ViewModel where Self.DataType == Car {
    func getName() -> String {
        return data.name
    }
    
    func getDescription() -> String {
        return data.description
    }
    
    func getImage() -> UIImage {
        let image: UIImage
        switch data.imageEnum {
        case .one: image = #imageLiteral(resourceName: "football")
        case .two: image = #imageLiteral(resourceName: "volleyball")
        case .three: image = #imageLiteral(resourceName: "softball")
        }
        return image
    }
}

// in swift 4 you cannot override type aliases, however you can do this craziness
class CarDetailViewModel: ViewModel, ExpressedCollectionViewCellType  {
    typealias CollectionCellType = CarDetailCollectionViewCell
    
    var data: Car
    
    required init(data: Car) {
        self.data = data
    }
    
    var collectionViewCellSize: CGSize? {
        return .init(width: 200, height: 200)
    }
}

