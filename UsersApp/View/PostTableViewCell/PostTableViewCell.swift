//
//  PostTableViewCell.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 8/05/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func register() -> UINib {
        UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
    static var identifier: String {
        get {
            "PostTableViewCell"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(viewModel: PostsTableCellViewModel) {
        self.title.text = viewModel.title
        self.body.text = viewModel.body
    }
    
}
