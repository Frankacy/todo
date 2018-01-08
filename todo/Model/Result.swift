//
//  Result.swift
//  todo
//
//  Created by Francois Courville on 2018-01-04.
//  Copyright © 2018 iOS Coach Frank. All rights reserved.
//

import Foundation

enum Result<Type, Error: Swift.Error> {
    case success(Type)
    case failure(Error)
}
