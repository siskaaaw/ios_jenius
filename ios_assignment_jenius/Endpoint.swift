//
//  Endpoint.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation

class Endpoint {
    
    private let BASE_URL = "https://simple-contact-crud.herokuapp.com/"
    
    private let contact = "contact"
    
    func contactAPI() -> String {
        return "\(BASE_URL)\(contact)"
    }
    
    func contactAPI(id: String) -> String {
        return "\(BASE_URL)\(contact)/\(id)"
    }
}
