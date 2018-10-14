//
//  ContactListRouter.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit

class ContactListRouter: ContactListRouterProtocol {
    
    static func initPresenter(vc: ContactListViewController) -> ContactListPresenterProtocol {
        let presenter: ContactListPresenterProtocol & ContactOutputInteractorProtocol = ContactListPresenter()
        let interactor: ContactInputInteractorProtocol = ContactInteractor()
        let router: ContactListRouterProtocol = ContactListRouter()
        
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.viewController = vc
        interactor.presenter = presenter
        
        return presenter
    }
    
    func presentToAddNewContact(view: ContactListViewProtocol) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewContactViewController")
    
        if let source = view as? UIViewController {
            source.present(vc, animated: true, completion: nil)
        }
    }
    
    func pushToContactDetail(view: ContactListViewProtocol, contact: Contact?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navVc = storyboard.instantiateViewController(withIdentifier: "AddNewContactViewController") as! UINavigationController
        let vc = navVc.viewControllers.first as! AddNewContactViewController
        vc.contact = contact
        
        if let source = view as? UIViewController {
            source.present(navVc, animated: true, completion: nil)
        }
    }

}
