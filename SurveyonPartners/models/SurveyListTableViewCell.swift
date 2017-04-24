//
//  SurveyListTableViewCell.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import UIKit

class SurveyListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var surveyNo: UILabel!
  @IBOutlet weak var titleName: UILabel!
  @IBOutlet weak var loi: UILabel!
  @IBOutlet weak var pointLabel: UILabel!
  @IBOutlet weak var pointImage: UIImageView!
  @IBOutlet weak var frameView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.frameView.layer.cornerRadius = 10
    self.frameView.layer.masksToBounds = true
    self.frameView.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.frameView.layer.shadowColor = UIColor.black.cgColor
    self.frameView.layer.shadowRadius = 1
    self.frameView.layer.shadowOpacity = 0.25
    self.frameView.clipsToBounds = false;
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setCell(surveyListItemProtocol: SurveyListItem) {
//    self.surveyNo = String(surveyListItemProtocol.surveyId)
    
  }
}
