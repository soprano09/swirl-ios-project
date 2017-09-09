//
//  DiscoverWireframe.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/8/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import UIKit

protocol DiscoverModuleDelegate: class {}

final class DiscoverWireframe {
    fileprivate weak var moduleDelegate: DiscoverModuleDelegate?

    init(moduleDelegate: DiscoverModuleDelegate) {
        self.moduleDelegate = moduleDelegate
    }
}

extension DiscoverWireframe: ControllerGettable {
    var viewController: UIViewController {
        return DiscoverViewController(message: "Discover Works!")
    }
}
