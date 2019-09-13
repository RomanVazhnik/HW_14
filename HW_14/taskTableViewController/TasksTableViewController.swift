//
//  TasksTableViewController.swift
//  HW_14
//
//  Created by Роман Важник on 07/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import RealmSwift

class TasksTableViewController: UITableViewController {
    
    var tasksList: TasksList!
    
    var uncomplitedTasksList: Results<Task>!
    var complitedTasksList: Results<Task>!
    
    var tag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterTasks()
        setupNavigationController()
        
    }
    
    @objc private func addTask() {
        let newTask = Task(value: ["name": "NewTask"])
        DataBaseManager.shared.addTaskInTaskList(taskList: tasksList, task: newTask)
        tableView.insertRows(at: [IndexPath(row: uncomplitedTasksList.count-1, section: 0)], with: .automatic)
    }
    
    private func filterTasks() {
        complitedTasksList = tasksList.tasks.filter("isComplit = true")
        uncomplitedTasksList = tasksList.tasks.filter("isComplit = false")
    }
    
    private func setupNavigationController() {
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
    }

}
