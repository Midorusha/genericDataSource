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
    var dataSourceA: ArrayDataSource<ItemA, ExampleCellA>!
    var dataSourceB: ArrayDataSource<ItemB, ExampleCellB>!
    var dataSourceC: ArrayDataSource<ItemC, ExampleCellC>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceA = ArrayDataSource<ItemA, ExampleCellA>(from: Items.allA, collectionView: collectionView)
        dataSourceB = ArrayDataSource<ItemB, ExampleCellB>(from: Items.allB, collectionView: collectionView)
        dataSourceC = ArrayDataSource<ItemC, ExampleCellC>(from: Items.allC, collectionView: collectionView)
        
        setDataSource(source: dataSourceA)
    }
    
    func setDataSource(source: UICollectionViewDelegate & UICollectionViewDataSource) {
        collectionView.dataSource = source
        collectionView.delegate = source
        collectionView.reloadData()
    }

    @IBAction func segmentedControlStateChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setDataSource(source: dataSourceA)
        case 1:
            setDataSource(source: dataSourceB)
        case 2:
            setDataSource(source: dataSourceC)
        default:
            break
        }
    }
}
