//
//  MainTableViewController.swift
//  HW_14
//
//  Created by Роман Важник on 07/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import RealmSwift

class MainTableViewController: UITableViewController {

    var tasks: Results<TasksList>!
    
    private let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realm.objects(TasksList.self)
        
        setupNavigationBar()
        
        // add refresh on table
        refresh.addTarget(self, action: #selector(reloadTable), for: .valueChanged)
        tableView.addSubview(refresh)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @objc private func reloadTable() {
        tableView.reloadData()
        refresh.endRefreshing()
    }
    
    @objc private func addTask() {
        let newTask = TasksList(value: ["name": "NewTask"])
        DataBaseManager.shared.saveTask(newTask)
        tableView.insertRows(at: [IndexPath(row: tasks.count-1, section: 0)], with: .automatic)
    }

    private func setupNavigationBar() {
        
        title = "Task list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }

}
