//
//  AddNewContactViewController.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit

class AddNewContactViewController: UIViewController {
    
    @IBOutlet weak var firstNameLbl: UITextField!
    @IBOutlet weak var lastNameLbl: UITextField!
    @IBOutlet weak var yearOfBirthTf: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var nameImageLbl: UILabel!
    @IBOutlet weak var saveContactBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var deleteContact: UIButton!
    
    var presenter: AddNewContactPresenterProtocol? = nil
    var yearPickerView = UIPickerView()
    var pickerController = UIImagePickerController()
    
    var contact: Contact?
    var imageData: Data?
    
    var currentYear: Int!
    var selectedYear: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AddNewContactRouter.initPresenter(vc: self)
        currentYear = Calendar.current.component(.year, from: Date())
        
        saveContactBtn.target = self
        
        deleteContact.layer.cornerRadius = 12.0
        deleteContact.backgroundColor = .red
        deleteContact.setTitleColor(.white, for: .normal)
        
        cancelBtn.target = self
        cancelBtn.action = #selector(dismissPage)
        
        addPhotoBtn.addTarget(self, action: #selector(presentGalleryPage), for: .touchUpInside)
        
        pickerController.delegate = self
        
        firstNameLbl.delegate = self
        lastNameLbl.delegate = self
        
        avatarImageView.setCircularView()
        
        if contact != nil {
            setViewForEditContact()
        } else {
            setViewForNewContact()
        }
        showYearPicker()
    }
}

extension AddNewContactViewController: AddNewContactViewProtocol {
    func setViewEnable(isEnable: Bool) {
        firstNameLbl.isEnabled = isEnable
        lastNameLbl.isEnabled = isEnable
        yearOfBirthTf.isEnabled = isEnable
    }
    
    @objc func activateEditForm() {
        setViewEnable(isEnable: true)
        firstNameLbl.becomeFirstResponder()
        
        saveContactBtn.title = "Update"
        saveContactBtn.action = #selector(requestUpdateContactAPI)
    }
    
    func setViewForNewContact() {
        saveContactBtn.action = #selector(requestSaveContactAPI)
        deleteContact.isHidden = true
    }
    
    func setViewForEditContact() {
        setViewEnable(isEnable: false)
        
        firstNameLbl.text = contact?.firstName
        lastNameLbl.text = contact?.lastName
        
        let firstName = contact?.firstName
        let lastName = contact?.lastName
        
        avatarImageView.backgroundColor = .blue
        nameImageLbl.text = "\(firstName?.prefix(1) ?? "")\(lastName?.prefix(1) ?? "")"
        
        selectedYear = currentYear - contact!.age!
        yearOfBirthTf.text = "\(selectedYear ?? 0)"
        
        saveContactBtn.title = "Edit"
        saveContactBtn.action = #selector(activateEditForm)
        
        deleteContact.isHidden = false
        deleteContact.addTarget(self, action: #selector(requestDeleteContactAPI), for: .touchUpInside)
    }
    
    
    @objc func requestDeleteContactAPI() {
        presenter?.requestDeleteContactAPI(contact: contact)
    }
    
    @objc func requestUpdateContactAPI() {
        let contact = setContact()
        contact.id = self.contact?.id
        
        presenter?.requestUpdateContactAPI(contact: contact)
    }
    
    func showYearPicker() {
        let toolbar  = UIToolbar()
        toolbar.sizeToFit()
        
        let doneToolbar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(pickerViewDonePressed))
        toolbar.setItems([doneToolbar], animated: true)
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        
        yearOfBirthTf.inputAccessoryView = toolbar
        yearOfBirthTf.inputView = yearPickerView
    }
    
    @objc func pickerViewDonePressed() {
        yearOfBirthTf.resignFirstResponder()
        
        let index = yearPickerView.selectedRow(inComponent: 0)
        selectedYear = currentYear - index
        
        yearOfBirthTf.text = "\(selectedYear ?? 0)"
    }
    
    @objc func requestSaveContactAPI() {
        let contact = setContact()
        
        presenter?.requestSaveContactAPI(contact: contact)
    }
    
    func setContact() -> Contact {
        let contact = Contact()
        contact.firstName = firstNameLbl.text ?? ""
        contact.lastName = lastNameLbl.text ?? ""
        contact.age = currentYear - selectedYear
        contact.photoData = imageData
        
        return contact
    }
    
    @objc func presentGalleryPage() {
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        
        pickerController.allowsEditing = false
        self.present(pickerController, animated: true)
    }
    
    @objc func dismissPage() {
        presenter?.dismissPage()
    }
}

extension AddNewContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let year = Calendar.current.component(.year, from: Date())
        return "\(year-row)"
    }
}

extension AddNewContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.image = image
            
            let resizeImage = avatarImageView.image?.resizeUIImage(targetSize: CGSize(width: 600, height: 600))
            imageData = resizeImage?.jpegData(compressionQuality: 100)
            
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddNewContactViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameImageLbl.text = "\(firstNameLbl.text?.prefix(1) ?? "")\(lastNameLbl.text?.prefix(1) ?? "")"
    }
}
