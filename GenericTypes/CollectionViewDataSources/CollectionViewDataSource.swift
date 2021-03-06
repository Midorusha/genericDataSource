//
//  CollectionViewDataSource.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

//Data Source Abstraction

class CollectionViewDataSource<Provider, Cell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where
    Provider: DataProvider,
    Cell: CellConfigurable,
    Cell: UICollectionViewCell,
    Provider.T == Cell.T
{
    let dataProvider: Provider
    let collectionView: UICollectionView
    
    init(provider: Provider, collectionView: UICollectionView) {
        self.dataProvider = provider
        self.collectionView = collectionView
        super.init()
    }
    
    func setupDatasource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellReuseIdentifier, for: indexPath) as? Cell,
            let item = dataProvider.item(at: indexPath)
            else {
                fatalError("Could Not Dequeue Cell or get item from provider")
        }
        cell.config(item, at: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberofSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Cell.cellSize
    }
}


class CollectionViewDataProvider<T>: DataProvider {
    var items: [[T]]
    
    init(items: [[T]]) {
        self.items = items
    }
    
    func numberofSections() -> Int {
        return items.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        let sectionItems = items[section]
        return sectionItems.count
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0, indexPath.section < items.count else { return nil }
        let sectionItems = items[indexPath.section]
        guard indexPath.row >= 0, indexPath.row < sectionItems.count else { return nil }
        return sectionItems[indexPath.row]
    }
    
    func updateItem(at indexPath: IndexPath, value: T) {
        items[indexPath.section][indexPath.row] = value
    }
}
