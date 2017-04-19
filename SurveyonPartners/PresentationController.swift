//
//  PresentationController.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/04/17.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation
import UIKit

final internal class PresentationController: UIPresentationController {
  
  fileprivate lazy var overlay: SurveyonPartnersOverlayView = {
    return SurveyonPartnersOverlayView(frame: .zero)
  }()
  
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    overlay.frame = (presentingViewController?.view.bounds)!
  }
  
  override func presentationTransitionWillBegin() {
    overlay.frame = containerView!.bounds
    containerView!.insertSubview(overlay, at: 0)
    
    presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
      self.overlay.alpha = 1.0
    }, completion: nil)
  }
  
  override func dismissalTransitionWillBegin() {
    presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
      self.overlay.alpha = 0.0
    }, completion: nil)
  }
  
  override func containerViewWillLayoutSubviews() {
//    presentedView!.frame = frameOfPresentedViewInContainerView
  }
  
}
