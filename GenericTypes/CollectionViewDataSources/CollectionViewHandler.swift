//
//  CollectionViewHandler.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/28/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class CollectionViewHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    typealias RootDataSource = NSObject & UICollectionViewDataSource & ExpressibleCollectionViewCell
    private let dataSource: RootDataSource
    
    public init(dataSource: RootDataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    public func register(with collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        dataSource.registerCells(with: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections(in: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return dataSource.collectionView(collectionView, canMoveItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        return dataSource.collectionView(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
}
