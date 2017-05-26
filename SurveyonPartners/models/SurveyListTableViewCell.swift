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
    self.surveyNo.textColor = UIColor(red: 200/255, green: 199/255, blue: 204/255, alpha: 1.0)
    self.titleName.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1.0)
    self.pointLabel.textColor = UIColor(red: 57/255, green: 152/255, blue: 71/255, alpha: 1.0)
    self.pointImage.image = SurveyonPartners.getImage(name: "icon-point.png")
    self.loi.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
    self.frameView.layer.cornerRadius = 2.0
    self.frameView.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.frameView.layer.shadowRadius = 2.0
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
