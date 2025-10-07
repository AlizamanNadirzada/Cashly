//
//  ProfileViewController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.08.25.
//

import UIKit

final class ProfileViewController: BaseViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let headerView = HeaderView()
    private let bottomView = UIView()
    
    //MARK: Property
    private let viewModel = ProfileViewModel()
    private let userDatasource: UserDataProtocol = UserLocalDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCurrentUser()
    }
    
    override func configureUI() {
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 30
        bottomView.layer.masksToBounds = true
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .button01
        
        view.addSubviews(headerView, bottomView)
        bottomView.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            // Header View
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            headerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            // Bottom View
            bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: view.frame.height - headerView.frame.height),
            bottomView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            // Table View
            tableView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }
    
    private func loadCurrentUser() {
        guard let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
              let userObject = userDatasource.getUserByEmail(email) else {
            print("User not found")
            return
        }
        
        headerView.configureData(user: userObject)
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseIdentifier, for: indexPath) as! ProfileCell
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        var config = UIListContentConfiguration.cell()
        config.text = item.title
        config.image = UIImage(systemName: item.icon)
        cell.contentConfiguration = config
        cell.tintColor = .label
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .init(55)
    }
}
