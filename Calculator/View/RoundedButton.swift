//
//  RoundedButton.swift
//  Calculator
//
//  Created by Rohit Jangid on 19/09/20.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height / 2
//        layer.cornerRadius = 15
        clipsToBounds = true
        layer.backgroundColor = .none
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 0.7254901961, green: 0.7333333333, blue: 0.8745098039, alpha: 1)
//        layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.5568627451, blue: 0.8039215686, alpha: 1)
        
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowRadius = 10
//        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowColor = #colorLiteral(red: 0.5294117647, green: 0.5568627451, blue: 0.8039215686, alpha: 1)
    }

}
