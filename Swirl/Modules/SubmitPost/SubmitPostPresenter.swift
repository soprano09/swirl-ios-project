//
//  SubmitPostPresenter.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/21/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import Foundation

protocol SubmitPostPresentable {}

final class SubmitPostPresenter {
    fileprivate let interactor: SubmitPostInteractable

    init(interactor: SubmitPostInteractable) {
        self.interactor = interactor
    }
}

extension SubmitPostPresenter: SubmitPostPresentable {}
