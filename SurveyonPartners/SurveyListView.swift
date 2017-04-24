//
//  SurveyListView.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import UIKit

protocol SurveyListViewDelegate: class {
  func shouldDismissSurveyListView() -> Void
}

public class SurveyListView: UIView {
  
  @IBOutlet weak var closeView: UIImageView!
  
  @IBOutlet weak var tableView: UITableView!
  
  weak var surveyListViewDelegate: SurveyListViewDelegate?
  
  override public func awakeFromNib() {
    let bundleIdentifier = "com.surveyon.partners.SurveyonPartners"
    let bundle = Bundle(identifier: bundleIdentifier)
    closeView.image = UIImage(named: "icon-close.png", in: bundle, compatibleWith: nil)
    closeView.isUserInteractionEnabled = true
    closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SurveyListView.closeButtonTapped)))
    
  }
  
  func closeButtonTapped(sender: UITapGestureRecognizer) {
    surveyListViewDelegate?.shouldDismissSurveyListView()
  }
  
}
