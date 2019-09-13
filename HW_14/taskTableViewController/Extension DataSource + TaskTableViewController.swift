//
//  Extension DataSource + TaskTableViewController.swift
//  HW_14
//
//  Created by Роман Важник on 09/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

// MARK: - Table view data source

extension TasksTableViewController {
    
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
        if editingStyle == .delete {
            if indexPath.section == 0 {
                DataBaseManager.shared.deleteTaskInList(task: uncomplitedTasksList[indexPath.row])
            } else {
                DataBaseManager.shared.deleteTaskInList(task: complitedTasksList[indexPath.row])
            }
            tag = 0
            tableView.reloadData()
        }
        //tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Complited tasks" : "Uncomplited tasks"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tag = 0
        if indexPath.section == 0 {
            DataBaseManager.shared.changeComplitState(task: uncomplitedTasksList[indexPath.row])
        } else {
            DataBaseManager.shared.changeComplitState(task: complitedTasksList[indexPath.row])
        }
        tableView.reloadData()
    }
}
