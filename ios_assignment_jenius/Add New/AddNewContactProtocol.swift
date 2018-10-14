//
//  AddNewContactProtocol.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 14/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation

protocol AddNewContactViewProtocol: class {
    func requestSaveContactAPI()
    func requestDeleteContactAPI()
    func requestUpdateContactAPI()
    
    func setViewForNewContact()
    func setViewForEditContact()
    func setViewEnable(isEnable: Bool)
    func activateEditForm()
    
    func setContact() -> Contact
    func pickerViewDonePressed()
    func presentGalleryPage()
    func dismissPage()
    func showYearPicker()
    
}

protocol AddNewContactPresenterProtocol: class {
    var view: AddNewContactViewProtocol? { get set }
    var interactor: ContactInputInteractorProtocol? { get set }
    var router: AddNewContactRouterProtocol? { get set }
    
    func requestSaveContactAPI(contact: Contact?)
    func requestUpdateContactAPI(contact: Contact?)
    func requestDeleteContactAPI(contact: Contact?)
    
    func dismissPage()
}

protocol AddNewContactRouterProtocol: class {
    static func initPresenter(vc: AddNewContactViewController) -> AddNewContactPresenterProtocol
    func dismissPage(view: AddNewContactViewProtocol)
}
