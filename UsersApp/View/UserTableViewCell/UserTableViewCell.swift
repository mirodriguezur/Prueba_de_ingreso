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
        // Initialization code
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
    
    func setupCell(viewModel: UserTableCellViewModel) {
        self.name.text = viewModel.name
        self.phone.text = viewModel.phone
        self.email.text = viewModel.email
    }
    
}