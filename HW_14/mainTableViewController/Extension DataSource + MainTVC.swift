//
//  Extension DataSource + MainTVC.swift
//  HW_14
//
//  Created by Роман Важник on 09/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit


// MARK: - Table view data source

extension MainTableViewController {
    
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
            DataBaseManager.shared.deleteTaskList(for: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if let indexPath = tableView.indexPathForSelectedRow {
            let taskVC = segue.destination as! TasksTableViewController
            taskVC.tasksList = tasks[indexPath.row]
            taskVC.index = indexPath.row
        }
    }
    
}
