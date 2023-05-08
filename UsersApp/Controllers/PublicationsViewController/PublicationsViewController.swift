//
//  PublicationsViewController.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 8/05/23.
//

import UIKit

class PublicationsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var publications: UITextView!
    
    var nameText: String?
    var phoneText: String?
    var emailText: String?
    var publicationsText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = false
        
        name.text = nameText
        phone.text = phoneText
        email.text = emailText
    }
    
    init(){
        super.init(nibName: "PublicationsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
