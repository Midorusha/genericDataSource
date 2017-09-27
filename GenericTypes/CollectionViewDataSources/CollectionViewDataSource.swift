//
//  CollectionViewDataSource.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/21/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

    public func register(with collectionView: UICollectionView) {
        precondition(dataSource.count > 0, "Must have at least 1 item.")
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells(with: collectionView)
    }
    
    private func registerCells(with collectionView: UICollectionView) {
        let flattendDataSource = dataSource.flatMap{ $0 }
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
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource[indexPath.section][indexPath.row].collectionViewCellSize ?? .zero
    }
}
