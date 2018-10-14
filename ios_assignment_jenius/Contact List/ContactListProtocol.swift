//
//  ContactListProtocol.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit

protocol ContactListViewProtocol: class {
    func showLoading()
    func dismissLoading()
    
    func showContactList(contacts: [Contact])
    func requestContactList()
    func presentToAddNewContact()
    func pushToContactDetail(index: Int)
}

protocol ContactListPresenterProtocol: class {
    var view: ContactListViewProtocol? { get set }
    var interactor: ContactInputInteractorProtocol? { get set }
    var router: ContactListRouterProtocol? { get set }
    
    func presentToAddNewContact()
    func pushToContactDetail(contact: Contact?)
    func requestContactList()
}


protocol ContactListRouterProtocol: class {
    static func initPresenter(vc: ContactListViewController) -> ContactListPresenterProtocol
    func presentToAddNewContact(view: ContactListViewProtocol)
    func pushToContactDetail(view: ContactListViewProtocol, contact: Contact?)

}
