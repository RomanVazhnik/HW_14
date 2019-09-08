//
//  MainTableViewController.swift
//  HW_14
//
//  Created by Роман Важник on 07/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import RealmSwift

class MainTableViewController: UITableViewController {

    private var tasks: Results<TasksList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realm.objects(TasksList.self)
        
        setupNavigationBar()
        
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
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        
        let name = tasks[indexPath.row].name
        let count = tasks[indexPath.row].tasks.count
        
        cell.setValues(textForTextField: name, count: count)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataBaseManager.shared.deleteTask(for: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let taskVC = segue.destination as! TasksTableViewController
            taskVC.tasksList = tasks[indexPath.row]
            taskVC.index = indexPath.row
        }
    }

}
