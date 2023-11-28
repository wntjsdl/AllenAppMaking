//
//  Utils.swift
//  MyMemory
//
//  Created by prologue on ..
//  Copyright © 2017년 rubypaper. All rights reserved.
//
extension UIViewController {
  var tutorialSB: UIStoryboard {
    return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
  }
  func instanceTutorialVC(name: String) -> UIViewController? {
    return self.tutorialSB.instantiateViewController(withIdentifier: name)
  }
}
