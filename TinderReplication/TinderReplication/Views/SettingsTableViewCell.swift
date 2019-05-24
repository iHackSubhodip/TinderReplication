//
//  SettingsTableViewCell.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 24/05/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    let textField: SettingsTextField = {
        let textField = SettingsTextField()
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
        textField.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
