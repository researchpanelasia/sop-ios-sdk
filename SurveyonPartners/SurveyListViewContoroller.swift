//
//  SurveyListViewContoroller.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class SurveyListViewContoroller: UIViewController {
  
  @IBOutlet weak var closeView: UIImageView!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    closeView.isUserInteractionEnabled = true
    closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SurveyListViewContoroller.closeButtonTapped)))
  }
  
  func closeButtonTapped(_ sender:AnyObject){
    dismiss(animated: false, completion: nil)
  }
  
}
