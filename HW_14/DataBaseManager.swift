//
//  DataBaseManager.swift
//  HW_14
//
//  Created by Роман Важник on 07/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class DataBaseManager {
    static var shared = DataBaseManager()
    
    func saveTask(_ taskLists: TasksList) {
        try! realm.write {
            realm.add(taskLists)
        }
    }
    
    // Добавить задачу в taskList
    func addTaskInTaskList(taskList: TasksList, task: Task) {
        try! realm.write {
            taskList.tasks.append(task)
        }
    }
    
    // Поменять свойство isComplit в task
    func changeComplitState(task: Task) {
        try! realm.write {
            task.isComplit.toggle()
        }
    }
    
    // Удалить задачу в листе
    func deleteTaskInList(task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    // Удалить лист
    func deleteTaskList(taskList: TasksList) {
        try! realm.write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    // Поменять имя taskList
    func editTask(newName: String, index: Int) {
        let task = realm.objects(TasksList.self)[index]
        try! realm.write {
            task.name = newName
        }
    }
    
    // Поменять task в TaskList
    func editTaskInList(newTaskName: String, index: Int, taskList: TasksList) {
        try! realm.write {
            taskList.tasks[index].name = newTaskName
        }
    }
    
}

