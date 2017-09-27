//
//  NibDefinedView.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

class NibDefinedView: UIView, NibDefinedBaseView {
    private var contentView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    // IF YOU SUBCLASS MORE THAN ONCE YOU MUST OVERRIDE THIS
    var nibName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func connectXib(xibView: UIView) {
        contentView = xibView
    }
}
