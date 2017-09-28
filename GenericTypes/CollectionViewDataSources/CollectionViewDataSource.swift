//
//  CollectionViewDataSource.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/21/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, ExpressibleCollectionViewCell {
    var cellClassName: String = "\(self.self)"
    var collectionViewCellSize: CGSize? = .zero
    
    private let dataSource: [[ExpressibleCollectionViewCell]]
    
    public init(items: [[ExpressibleCollectionViewCell]]) {
        dataSource = items
        super.init()
    }
    
    public convenience init(items: [ExpressibleCollectionViewCell]) {
        self.init(items: [items])
    }
    
    public convenience init(items: ExpressibleCollectionViewCell...) {
        self.init(items: items)
    }
    
    public func registerCells(with collectionView: UICollectionView) {
        // TODO: revisit this, to have everything loaded up front, at once, flattened or have each cell register
        // documentation says its safe but, how much overhead would it be to constantly overwrite the last registration and loading of the same nib?
        let flattendDataSource = dataSource.flatMap { $0 }
        let uniqueCellNames:Set<String> = Set(flattendDataSource.flatMap({ $0.cellClassName }))
        
        for cellName in uniqueCellNames {
            let cellNib = UINib.init(nibName: cellName, bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: cellName)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource[indexPath.section][indexPath.row]
        return item.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let item = dataSource[indexPath.section][indexPath.row]
        return item.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        let item = dataSource[indexPath.section][indexPath.row]
        return item.collectionView(collectionView, canMoveItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // DEFINITELY AN ISSUE HERE
        let item = dataSource[destinationIndexPath.section][destinationIndexPath.row]
        return item.collectionView(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.section][indexPath.row]
        return item.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
}
