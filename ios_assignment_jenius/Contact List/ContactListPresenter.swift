//
//  ContactListPresenter.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation

class ContactListPresenter: ContactListPresenterProtocol {

    var view: ContactListViewProtocol?
    var interactor: ContactInputInteractorProtocol?
    var router: ContactListRouterProtocol?
    
    func presentToAddNewContact() {
        router?.presentToAddNewContact(view: view!)
    }
    
    func pushToContactDetail(contact: Contact?) {
        router?.pushToContactDetail(view: view!, contact: contact)
    }
    
    func requestContactList() {
        interactor?.getAllContactAPI()
    }

}

extension ContactListPresenter: ContactOutputInteractorProtocol {
    func onSuccessRequest(data: Any) {
        let contactList = data as! ContactData
        view?.showContactList(contacts: contactList.data!)
    }
    
    func onFailedRequest(message: String) {
        
    }
    
    
}
