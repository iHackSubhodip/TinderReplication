//
//  UserModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 26/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

struct UserModel{
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func convertToCardViewModel() -> TinderCardViewModel{
        
        let attributedUserInfoText = NSMutableAttributedString(string: name, attributes:[.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedUserInfoText.append(NSMutableAttributedString(string: "  \(age)", attributes:[.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedUserInfoText.append(NSMutableAttributedString(string: "\n\(profession)", attributes:[.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return TinderCardViewModel(imageName: imageName, attributedString: attributedUserInfoText, textAlignment: .left)
    }
}


