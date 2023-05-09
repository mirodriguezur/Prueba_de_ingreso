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
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = PostsViewModel()
    
    var postsDataSource: [PostsTableCellViewModel] = []
    
    var nameText: String?
    var phoneText: String?
    var emailText: String?
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = false
        
        name.text = nameText
        phone.text = phoneText
        email.text = emailText
        
        bindViewModel()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getPosts(userId: userId ?? 1)
    }
    
    init(){
        super.init(nibName: "PublicationsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel() {
        viewModel.posts.bind { [weak self] posts in
            guard let self = self,
                  let posts = posts else {
                return
            }
            self.postsDataSource = posts
            self.reloadTableView()
        }
    }
}

extension PublicationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        registerCell()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerCell(){
        tableView.register(PostTableViewCell.register(), forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: postsDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
