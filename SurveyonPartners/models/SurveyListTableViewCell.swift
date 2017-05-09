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
    self.frameView.layer.cornerRadius = 2.0
    self.frameView.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.frameView.layer.shadowRadius = 1.0
    self.frameView.layer.shadowOpacity = 0.5
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setCell(surveyListItem: SurveyListItem) {
    self.surveyNo!.text = surveyListItem.surveyIdLabel
    self.titleName!.text = surveyListItem.title
    self.loi!.text = surveyListItem.loi
  }
  
}
