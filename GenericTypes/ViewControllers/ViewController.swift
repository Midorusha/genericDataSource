//
//  ViewController.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/20/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    private var collectionViewHandler: CollectionViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animals = [
            Animal(name: "Akita", description: "Massive Pupper", weight: 160),
            Animal(name: "Kangal", description: "Massive Eurpean Pupper", weight: 260),
            Animal(name: "Mastiff", description: "Massive Animal", weight: 240),
            Animal(name: "Pitbull", description: "Really just a teddy bear", weight: 120),
        ]
        
        let cars = [
            Car(name: "Maserati", description: "Now comes as a SUV", imageEnum: .one),
            Car(name: "Bugatti", description: "Dream baby dream", imageEnum: .two),
            Car(name: "Tesla", description: "Probably the best SUV around, and eco friendly", imageEnum: .three),
        ]
        
        let animalViewModels: [ExpressibleCollectionViewCell] = animals.flatMap(AnimalViewModel.init)
        let carViewModels: [ExpressibleCollectionViewCell] = cars.flatMap(CarViewModel.init)
        
        var allViewModels = animalViewModels + carViewModels
        allViewModels.append(CarDetailViewModel(data: cars[0]))
        
        let collectionViewDataSource = CollectionViewDataSource(items: allViewModels)
        collectionViewHandler = CollectionViewHandler(dataSource: collectionViewDataSource)
        collectionViewHandler.register(with: collectionView)
    }
}
