//
//  TinderCardViewModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 27/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

struct TinderCardViewModel{
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

protocol TinderCardViewModelProtocol{
    func convertToCardViewModel() -> TinderCardViewModel
}
