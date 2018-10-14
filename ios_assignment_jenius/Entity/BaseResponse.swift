//
//  BaseResponse.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
    }
}
