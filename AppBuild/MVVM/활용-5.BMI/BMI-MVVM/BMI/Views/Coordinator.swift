//
//  Coordinator.swift
//  BMI
//
//  Created by JuSun Kang on 1/4/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
