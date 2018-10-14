//
//  ViewController.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactCollectionView: UICollectionView!
    @IBOutlet weak var addNewContactBtn: UIBarButtonItem!
    
    static let GET_CONTACT = "GET_CONTACT"
    var presenter: ContactListPresenterProtocol? = nil
    var contacts = [Contact]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Contacts"
        
        let contactNib = UINib(nibName: "ContactListViewCell", bundle: nil)
        contactCollectionView.register(contactNib, forCellWithReuseIdentifier: "contact_list_cell")
        
        presenter = ContactListRouter.initPresenter(vc: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(requestContactList),name: NSNotification.Name(rawValue: ContactListViewController.GET_CONTACT), object: nil)
        
        addNewContactBtn.target = self
        addNewContactBtn.action = #selector(presentToAddNewContact)
        
        requestContactList()
    }


}

extension ContactListViewController: ContactListViewProtocol  {
   
    func showLoading() {
        
    }
    
    func dismissLoading() {
        
    }
    
    func showContactList(contacts: [Contact]) {
        self.contacts = contacts
        
        contactCollectionView.delegate = self
        contactCollectionView.dataSource = self
        
        contactCollectionView.reloadData()
    }
    
    @objc func requestContactList() {
        presenter?.requestContactList()
    }
    
    @objc func presentToAddNewContact() {
        presenter?.presentToAddNewContact()
    }
    
    func pushToContactDetail(index: Int) {
        presenter?.pushToContactDetail(contact: contacts[index])
    }
}

extension ContactListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contact_list_cell", for: indexPath) as! ContactListViewCell
        cell.setContact(contact: contacts[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToContactDetail(index: indexPath.row)
    }
    
}

extension ContactListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 32), height: 60)
    }
}

