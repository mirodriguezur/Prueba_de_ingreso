//
//  UserTableViewCell.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.grid()
        containerView.addBorder(color: .lightGray, width: 1)
    }
    
    static func register() -> UINib {
        UINib(nibName: "UserTableViewCell", bundle: nil)
    }
    
    static var identifier: String {
        get {
            "UserTableViewCell"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let viewController = windowScene.windows.first?.rootViewController else { return }
        
        let publicationsView = PublicationsViewController()
        
        publicationsView.nameText = name.text
        publicationsView.phoneText = phone.text
        publicationsView.emailText = email.text
        
        viewController.present(publicationsView, animated: true)
    }
    
    func setupCell(viewModel: UserTableCellViewModel) {
        self.name.text = viewModel.name
        self.phone.text = viewModel.phone
        self.email.text = viewModel.email
    }
    
}
