//
//  SurveyListViewContoroller.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

struct ListItem {
  let surveyNo: String
  let titleName: String
  let loi: String
}

class SurveyListViewContoroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var closeView: UIImageView!
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var customView: UIView!
  
  var listItem = [ListItem]()
  
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
    cell.surveyNo.text? = "No001"
    cell.loi.text? = "10"
    cell.titleName.text? = "What is your date of birth?What is your date of birth?What is your date of birth?"
    cell.pointLabel.text? = "10 each"
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
}
