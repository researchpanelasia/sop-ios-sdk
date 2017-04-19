//
//  PresentationManager.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/04/14.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation
import UIKit

final internal class PresentationManager: NSObject, UIViewControllerTransitioningDelegate {
  
  var interactor: InteractiveTransition
  
  init(interactor: InteractiveTransition) {
    self.interactor = interactor
    super.init()
  }
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentationController = PresentationController(presentedViewController: presented, presenting: source)
    return presentationController
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactor.hasStarted ? interactor : nil
  }
  
}
