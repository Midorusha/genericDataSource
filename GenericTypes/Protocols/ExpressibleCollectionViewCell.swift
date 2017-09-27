//
//  ExpressibleCollectionViewCell.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

protocol ExpressibleCollectionViewCell: ExpressibleInterface {
    var cellClassName: String { get }
    var collectionViewCellSize: CGSize? { get }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
