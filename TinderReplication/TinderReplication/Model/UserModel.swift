//
//  UserModel.swift
//  TinderReplication
//
//  Created by Banerjee,Subhodip on 26/02/19.
//  Copyright © 2019 Banerjee,Subhodip. All rights reserved.
//

import UIKit

struct UserModel: TinderCardViewModelProtocol{
    var name: String?
    var age: Int?
    var profession: String?
    var imageNames: String?
    let uid: String?
    
    init(_ dictionary: [String: Any]){
        self.name = dictionary["fullName"] as? String ?? ""
        self.imageNames = dictionary["imageUrls"] as? String ?? ""
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
    func convertToCardViewModel() -> TinderCardViewModel{
        
        let attributedUserInfoText = NSMutableAttributedString(string: name ?? "", attributes:[.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        
        let ageString = age != nil ? "\(age!)" : "N\\A"
        attributedUserInfoText.append(NSMutableAttributedString(string: "  \(ageString)", attributes:[.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        let professionString = profession != nil ? profession! : "Not available"
        attributedUserInfoText.append(NSMutableAttributedString(string: "\n\(professionString)", attributes:[.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return TinderCardViewModel(imageNamesArray: [imageNames ?? ""], attributedString: attributedUserInfoText, textAlignment: .left)
    }
}


