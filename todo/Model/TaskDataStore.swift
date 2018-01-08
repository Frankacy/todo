//
//  TaskDataStore.swift
//  todo
//
//  Created by Francois Courville on 2017-12-26.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

class TaskDataStore: NSObject {
    var inbox: TaskList
    var userLists: [TaskList]

    override init() {
        inbox = TaskList(named: "Inbox")
        userLists = []
    }

    func addNewList(named name: String) {
        userLists.append(TaskList(named: name))
    }

    func removeList(list: TaskList) {
        if let index = userLists.index(of: list) {
            userLists.remove(at: index)
        }
    }

    func addTask(task: Task, to list: TaskList) {
        list.addTask(task: task)
    }
}
