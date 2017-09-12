//
//  ProfileInteractor.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/11/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol ProfileInteractable {}

final class ProfileInteractor {
    fileprivate weak var moduleDelegate: ProfileModuleDelegate?
    fileprivate let dataService: ProfileDataServiceable

    init(moduleDelegate: ProfileModuleDelegate?, dataService: ProfileDataServiceable) {
        self.moduleDelegate = moduleDelegate
        self.dataService = dataService
    }
}

extension ProfileInteractor: ProfileInteractable {}
