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
    var index: Int!
    
    var uncomplitedTasksList: Results<Task>!
    var complitedTasksList: Results<Task>!
    
    private var tag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterTasks()
        setupNavigationController()
        
    }
    
    private func setupNavigationController() {
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
    }
    
    @objc private func addTask() {
        let newTask = Task(value: ["name": "NewTask"])
        DataBaseManager.shared.addTaskInTaskList(newTask, index: index)
        tableView.insertRows(at: [IndexPath(row: uncomplitedTasksList.count-1, section: 0)], with: .automatic)
    }
    
    private func filterTasks() {
        complitedTasksList = tasksList.tasks.filter("isComplit = true")
        uncomplitedTasksList = tasksList.tasks.filter("isComplit = false")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? uncomplitedTasksList.count : complitedTasksList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        var task: Task!
        task = indexPath.section == 0 ? uncomplitedTasksList[indexPath.row] : complitedTasksList[indexPath.row]
        cell.setupView(task: task)
        cell.nameTextField.delegate = self
        cell.nameTextField.tag = tag
        tag += 1
        return cell
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataBaseManager.shared.deleteTaskInList(index: index, indexTask: indexPath.row)
        tag = 0
        tableView.reloadData()
        //tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Complited tasks" : "Uncomplited tasks"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tag = 0
        if indexPath.section == 0 {
            try! realm.write {
                uncomplitedTasksList[indexPath.row].isComplit.toggle()
            }
        } else {
            try! realm.write {
                complitedTasksList[indexPath.row].isComplit.toggle()
            }
        }
        tableView.reloadData()
    }

}
