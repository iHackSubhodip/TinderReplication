//
//  AdvertiserModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 27/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

struct AdvertiserModel:TinderCardViewModelProtocol {
    
    let tittle: String
    let posterImageName: String
    let brandname: String
    
    func convertToCardViewModel() -> TinderCardViewModel{
        let attributedString = NSMutableAttributedString(string: tittle, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        
        attributedString.append(NSMutableAttributedString(string: "\n" + brandname, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        return TinderCardViewModel(imageNamesArray: [posterImageName], attributedString: attributedString, textAlignment: .center)
    }
}


