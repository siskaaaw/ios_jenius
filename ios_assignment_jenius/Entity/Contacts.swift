//
//  Contacts.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import ObjectMapper

class Contact: Mappable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var age: Int?
    var photo: String?
    var photoData: Data?
    
    required init?(map: Map) {
        
    }
    
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        age <- map["age"]
        photo <- map["photo"]
    }
    
    func toJSON() -> [String : Any] {
        let data: [String : Any] = ["firstName":firstName ?? "",
                    "lastName": lastName ?? "",
                    "age": age ?? 0
        ]
        
        return data
    }
}

class ContactData: BaseResponse {
    var data: [Contact]?

    override func mapping(map: Map) {
        data <- map["data"]
    }
}
