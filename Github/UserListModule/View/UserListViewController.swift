//
//  UserListViewController.swift
//  Github
//
//  Created by Максим Алексеев on 02.01.2021.
//

import UIKit
import RxCocoa
import RxSwift

class UserListViewController: UIViewController {
    // MARK:- Dependencies
    
    // MARK:- Properties
    private let cellId = "UserListViewControllerTableViewCell"
    
    private let bag = DisposeBag()
    
    // MARK:- Views
    let tableView = UITableView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        configureTableView()
    }
    
    // MARK:- Configure
    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    
}

