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

//extension CollectionViewSomething: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//}
//class CollectionViewSomething<W, C>: NSObject where
//W: ExpressibleInterface, C: UICollectionViewCell, C: ConfigurableView, C.Item == W {
//    let dataSource: [W]? = nil
//
//    typealias ConfigurableCollectionViewCell = UICollectionViewCell & ConfigurableView
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard
//            let item = dataSource?[indexPath.item],
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: indexPath) as? C
//            else {
//                fatalError("Could Not Dequeue Cell or get item from provider")
//        }
//        return populate(configurable: cell, with: item)
//    }
//}

class CollectionViewDataSourceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let dataSource: [[ExpressibleCollectionViewCell]]
    
    init(items: [[ExpressibleCollectionViewCell]]) {
        dataSource = items
    }
    
    convenience init(items: [ExpressibleCollectionViewCell]) {
        self.init(items: [items])
    }
    
    convenience init(items: ExpressibleCollectionViewCell...) {
        self.init(items: items)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource[indexPath.section][indexPath.row]
        return item.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
}


// TODO: Wrap this in viewmodel s.t. item.populate(configurable: cell)
func populate<W, C>(configurable: C, with item: W) -> C where
    W: ExpressibleInterface, C: ConfigurableView, C.Item == W {
    configurable.config(item)
    return configurable
}

func foo() {
    let animal = Animal(name: "Akita", description: "Massive Pupper", weight: 160)
    let car = Car(name: "Maserati", description: "Epic car", weight: 2600)
    let animalVM = AnimalViewModel(data: animal)
    let carVM = CarViewModel(data: car)
    let t = CollectionViewDataSourceDelegate(items: animalVM, carVM)
    print(t)
}

protocol ViewModel {
    associatedtype DataType
//    var data: DataType { get set } // maybe and then have populate make the connection?
    init(data: DataType)
}

protocol ExpressibleInterface {}
extension ExpressibleInterface {
    func populate<C>(configurable: C) -> C where C: ConfigurableView, C.Item == Self {
        configurable.config(self)
        return configurable
    }
}

protocol ExpressedAsView: ExpressibleInterface {
    associatedtype ViewType: UIView, ConfigurableView
}

protocol ExpressibleCollectionViewCell: ExpressibleInterface {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol ExpressedCollectionViewCellType: ExpressibleCollectionViewCell {
    associatedtype CollectionCellType: UICollectionViewCell, ConfigurableView
}

extension ExpressedCollectionViewCellType where CollectionCellType.Item == Self {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionCellType.self)", for: indexPath) as? CollectionCellType else {
            fatalError("Casting error: \(#function)")
        }
//        return populate(configurable: cell, with: self)
        return self.populate(configurable: cell)
    }
}

protocol ConfigurableView {
    associatedtype Item
    func config(_ item: Item)
}

struct Animal {
    var name: String
    var description: String
    var weight: Int
}

class AnimalViewModel: ViewModel {
    var animal: Animal
    
    required init(data: Animal) {
        animal = data
    }
}

extension AnimalViewModel: ExpressedAsView {
    typealias ViewType = AnimalView
}

extension AnimalViewModel: ExpressedCollectionViewCellType {
    typealias CollectionCellType = AnimalCollectionViewCell
}

class AnimalCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    func config(_ item: AnimalViewModel) {
        titleLabel.text = item.animal.name
        subtitleLabel.text = item.animal.description
    }
}

class AnimalView: UIView, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    func config(_ item: AnimalViewModel) {
        titleLabel.text = item.animal.name
        descriptionLabel.text = item.animal.description
        weightLabel.text = "\(item.animal.weight)"
    }
}

class AnimalDetailCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet weak var animalView: AnimalView!
    
    func config(_ item: AnimalViewModel) {
        animalView.config(item)
    }
}

struct Car {
    var name: String
    var description: String
    var weight: Int
}

class CarViewModel: ViewModel {
    var car: Car
    
    required init(data: Car) {
        car = data
    }
}

extension CarViewModel: ExpressedAsView {
    typealias ViewType = CarView
}

extension CarViewModel: ExpressedCollectionViewCellType {
    typealias CollectionCellType = CarCollectionViewCell
}

class CarCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    func config(_ item: CarViewModel) {
        titleLabel.text = item.car.name
        subtitleLabel.text = item.car.description
    }
}

class CarView: UIView, ConfigurableView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    func config(_ item: CarViewModel) {
        titleLabel.text = item.car.name
        descriptionLabel.text = item.car.description
        weightLabel.text = "\(item.car.weight)"
    }
}

class CarDetailCollectionViewCell: UICollectionViewCell, ConfigurableView {
    @IBOutlet weak var carView: CarView!
    
    func config(_ item: CarViewModel) {
        carView.config(item)
    }
}

