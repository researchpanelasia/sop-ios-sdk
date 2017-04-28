//
//  SurveyListViewContoroller.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

class SurveyListViewContoroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var closeView: UIImageView!
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var customView: UIView!
  
  let identifier: String = "SurveyListTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    customView.layer.cornerRadius = 5
    
    tableView.register(UINib(nibName: "SurveyListTableViewCell", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners")), forCellReuseIdentifier: "SurveyListTableViewCell")
    tableView.separatorStyle = .none
    
    closeView.isUserInteractionEnabled = true
    closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SurveyListViewContoroller.closeButtonTapped)))
  }
  
  func closeButtonTapped(_ sender:AnyObject){
    dismiss(animated: false, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SurveyListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SurveyListTableViewCell
    cell.surveyNo.text? = (SurveyonPartners.showListItem[indexPath.row] as SurveyListItem).surveyIdLabel!
    cell.loi.text? = (SurveyonPartners.showListItem[indexPath.row] as SurveyListItem).loi!
    if cell.loi.text != "" {
      cell.loi.text! += " min"
    }
    cell.titleName.text? = (SurveyonPartners.showListItem[indexPath.row] as SurveyListItem).title!
    // TODO - get point value
//    let cookiePoint = profilingPointRule as! ProfilingPointRule
//    let pro = self.showListItem[0] as! Profiling
//    let point = cookiePoint.cookieProfilingPoint(profiling: pro)
    cell.pointLabel.text? = "10 each"
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return SurveyonPartners.showListItem.count
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
}
