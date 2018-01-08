//
//  TaskList.swift
//  todo
//
//  Created by Francois Courville on 2017-12-25.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

class TaskList: NSObject {
    let name: String
    var tasks: [Task] = []

    init(named name: String) {
        self.name = name
        super.init()
    }

    func addTask(task: Task) {
        self.tasks.append(task)
    }
}
