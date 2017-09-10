//
//  DataService.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/9/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol AuthServicable {
    var isAuthenticated: Bool { get }
}

final class DataService {
    static var defaultService: DataService {
        return DataService()
    }
}

extension DataService: AuthServicable {
    var isAuthenticated: Bool {
        return true
    }
}
