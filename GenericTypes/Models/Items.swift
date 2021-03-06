//
//  Items.swift
//  GenericTypes
//
//  Created by Jonathan Jones on 9/21/17.
//  Copyright © 2017 Jonathan Jones. All rights reserved.
//

import Foundation
import UIKit

struct ItemA {
    let title: String
    let subtitle: String
}

struct ItemB {
    let title: String
    let image: UIImage?
}

struct ItemC {
    let title: String
    let description: String
}

struct Items {
    static var allA = [
        ItemA(title: "First A", subtitle: "Testing OneTwo"),
        ItemA(title: "Second A", subtitle: "Testing ThreeFour"),
        ItemA(title: "Third A", subtitle: "Testing FiveSix"),
        ItemA(title: "Fourth A", subtitle: "Testing SevenEight")
    ]
    
    static var allB = [
        ItemB(title: "First B", image: #imageLiteral(resourceName: "basketBall")),
        ItemB(title: "Second B", image: #imageLiteral(resourceName: "softball")),
        ItemB(title: "Third B", image: #imageLiteral(resourceName: "football")),
        ItemB(title: "Fourth B", image: #imageLiteral(resourceName: "volleyball"))
    ]
    
    static var allC = [
        ItemC(title: "First C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder"),
        ItemC(title: "Second C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder"),
        ItemC(title: "Third C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder"),
        ItemC(title: "Fourth C", description: "Lorem ipsum and whatever else usually goes in the latin placeholder")
    ]
}
