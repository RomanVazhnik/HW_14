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
    
    func addTaskInTaskList(_ task: Task, index: Int) {
        let object = realm.objects(TasksList.self)[index]
        try! realm.write {
            object.tasks.append(task)
        }
    }
    
    func changeComplitState(index: Int, indexTask: Int) {
        let object = realm.objects(TasksList.self)[index]
        try! realm.write {
            object.tasks[indexTask].isComplit.toggle()
        }
    }
    
    func editTask(newName: String, index: Int) {
        let task = realm.objects(TasksList.self)[index]
        try! realm.write {
            task.name = newName
        }
    }
    
    func editTaskInList(newTaskName: String, index: Int, indexTask: Int) {
        let list = realm.objects(TasksList.self)[index]
        try! realm.write {
            list.tasks[indexTask].name = newTaskName
        }
    }
    
    func deleteTaskInList(index: Int, indexTask: Int) {
        let task = realm.objects(TasksList.self)[index].tasks[indexTask]
        try! realm.write {
            realm.delete(task)
        }
    }
    
    func deleteTask(for index: Int) {
        let task = realm.objects(TasksList.self)[index]
        try! realm.write {
            realm.delete(task)            
        }
    }
    
}

