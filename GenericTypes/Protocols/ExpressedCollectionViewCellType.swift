//
//  ExpressedCollectionViewCellType.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

protocol ExpressedCollectionViewCellType: ExpressibleCollectionViewCell {
    associatedtype CollectionCellType: UICollectionViewCell, ConfigurableView
}

extension ExpressedCollectionViewCellType where CollectionCellType.Item == Self {
    var cellClassName: String {
        return "\(CollectionCellType.self)"
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionCellType.self)", for: indexPath) as? CollectionCellType else {
            fatalError("Casting error: \(#function)")
        }
        return populate(configurable: cell)
    }
}
