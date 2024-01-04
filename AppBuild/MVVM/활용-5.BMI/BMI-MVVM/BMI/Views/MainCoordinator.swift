//
//  MainCoordinator.swift
//  BMI
//
//  Created by JuSun Kang on 1/4/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

//    func start() {
//        let vc = ViewController.init(coder: <#T##NSCoder#>)
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: false)
//    }
}
