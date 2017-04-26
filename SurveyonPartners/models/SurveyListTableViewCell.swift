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
    
    self.frameView.layer.cornerRadius = 5
    self.frameView.layer.shadowRadius = 1
    self.frameView.layer.shadowOpacity = 0.1
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setCell(surveyListItemProtocol: ListItem) {//SurveyListItem
    self.surveyNo!.text = surveyListItemProtocol.surveyNo//surveyListItemProtocol.surveyIdLabel
    self.titleName!.text = surveyListItemProtocol.titleName
    self.loi!.text = surveyListItemProtocol.loi
  }
  
}
