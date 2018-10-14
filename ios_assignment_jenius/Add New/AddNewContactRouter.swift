//
//  AddNewContactRouter.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 14/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit

class AddNewContactRouter: AddNewContactRouterProtocol {
    static func initPresenter(vc: AddNewContactViewController) -> AddNewContactPresenterProtocol {
        let presenter: AddNewContactPresenterProtocol & ContactOutputInteractorProtocol = AddNewContactPresenter()
        let interactor: ContactInputInteractorProtocol = ContactInteractor()
        let router: AddNewContactRouterProtocol = AddNewContactRouter()
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.viewController = vc
        interactor.presenter = presenter
        return presenter
    }
    
    func dismissPage(view: AddNewContactViewProtocol) {
        if let source = view as? UIViewController {
            source.dismiss(animated: true, completion: nil)
        }
    }
}
