//
//  Task.swift
//  todo
//
//  Created by Francois Courville on 2017-12-25.
//  Copyright © 2017 iOS Coach Frank. All rights reserved.
//

import UIKit

class Task: NSObject {
    let name: String
    let dueDate: Date?
    var completed: Bool = false

    let createdAt: Date

    init(name: String, dueDate: Date? = nil) {
        self.name = name
        self.createdAt = Date()
        self.dueDate = dueDate

        super.init()
    }

    func toggleCompletion() {
        completed = !completed
    }
}
