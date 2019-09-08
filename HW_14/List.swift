//
//  list.swift
//  HW_14
//
//  Created by Роман Важник on 07/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import RealmSwift

class TasksList: Object {
    @objc dynamic var name: String = ""
    var tasks = List<Task>()
}
