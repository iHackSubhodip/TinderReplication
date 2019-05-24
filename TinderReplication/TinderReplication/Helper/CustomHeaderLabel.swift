//
//  CustomHeaderLabel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 24/05/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class CustomHeaderLabel: UILabel{
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}
