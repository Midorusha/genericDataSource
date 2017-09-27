//
//  NibDefinedBaseView.swift
//  GenericTypes
//
//  Created by Chris Davis on 9/27/17.
//  Copyright © 2017 Chris Davis. All rights reserved.
//

import UIKit

protocol NibDefinedBaseView: AnyObject {
    var nibName: String { get }
    func xibSetup()
    func connectXib(xibView: UIView)
}

extension NibDefinedBaseView where Self: UIView {
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        connectXib(xibView: view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
