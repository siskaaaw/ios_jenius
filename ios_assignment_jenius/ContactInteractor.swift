//
//  GetContactInteractor.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper

protocol ContactInputInteractorProtocol: class {
    var presenter: ContactOutputInteractorProtocol? { get set }
    var viewController: UIViewController? { get set }
    
    func getAllContactAPI()
    func saveContactAPI(contact: Contact)
    func deleteContactAPI(contactId: String)
    func editContact(contactId: String, contact: Contact)
}

protocol ContactOutputInteractorProtocol: class {
    func onSuccessRequest(data: Any)
    func onFailedRequest(message: String)
}

class ContactInteractor: ContactInputInteractorProtocol, MainCallback {
    
    var presenter: ContactOutputInteractorProtocol?
    var viewController: UIViewController?
    
    let endpoint = Endpoint()
    let connection = ConnectionManager()
    
    func getAllContactAPI() {
        Alamofire.request(endpoint.contactAPI(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<ContactData>) in
            self.connection.viewController = self.viewController
            self.connection.mainCallback = self
            self.connection.connectionCallback(responseData: response)
        }
    }
    
    func saveContactAPI(contact: Contact) {
        let params = contact.toJSON()

        Alamofire.request(endpoint.contactAPI(), method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponse>) in
            self.connection.viewController = self.viewController
            self.connection.mainCallback = self
            self.connection.connectionCallback(responseData: response)
        }
    }
    
    func deleteContactAPI(contactId: String) {
        print("id delete \(contactId)")
        Alamofire.request(endpoint.contactAPI(id: contactId), method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponse>) in
            self.connection.viewController = self.viewController
            self.connection.mainCallback = self
            self.connection.connectionCallback(responseData: response)
        }
    }
    
    func editContact(contactId: String, contact: Contact) {
        let params = contact.toJSON()
        
        print("params \(params) \(contactId)")
        Alamofire.request(endpoint.contactAPI(id: contactId), method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<BaseResponse>) in
            self.connection.viewController = self.viewController
            self.connection.mainCallback = self
            self.connection.connectionCallback(responseData: response)
        }
    }
    
    func onSuccessResponse<T>(message: String, response: DataResponse<T>) {
        let data = response.result.value
        presenter?.onSuccessRequest(data: data as Any)
    }
    
}
