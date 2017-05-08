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
  
  var indicator: UIActivityIndicatorView?
  
  var showListItem: [SurveyListItem] = []
  
  var profilingPointRule: ProfilingPointRule?
  
  var researchPointRule: ResearchPointRule?
  
  func setRule<T,R>(profilingPointRule: T, researchPointRule: R) {
    self.profilingPointRule = profilingPointRule as? ProfilingPointRule
    self.researchPointRule = researchPointRule as? ResearchPointRule
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let info = SurveyonPartners.getSetupInfo() else {
      //TODO: should throw error?
      return
    }
    
    customView.layer.cornerRadius = 5
    self.showActivityIndicator(uiView: customView)
    
    tableView.register(UINib(nibName: "SurveyListTableViewCell", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners")), forCellReuseIdentifier: "SurveyListTableViewCell")
    tableView.separatorStyle = .none
    
    closeView.isUserInteractionEnabled = true
    closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SurveyListViewContoroller.closeButtonTapped)))
    
    let httpClient = HttpClient(appId: info.appId,
                                appMid: info.appMid,
                                secretKey: info.secretKey,
                                sopHost: info.sopHost,
                                sopConsoleHost: info.sopConsoleHost,
                                updateSpan: info.idfaUpdateSpan,
                                useHttps: info.useHttps,
                                verifyHost: info.verifyHost)
    
    httpClient.getSurveyList(completion: { (result) -> Void in
      switch result {
      case .success(let statusCode, let message, let rawBody):
        SOPLog.debug(message: "statusCode = \(statusCode), message = \(message), rawBody = \(rawBody)")
        
        self.showListItem = SurveyListItemFactory.create(data: rawBody)
        
        DispatchQueue.main.async {  
          self.hideActivityIndicator()
          if self.showListItem.count > 0 {
            self.tableView.reloadData()
          } else {
            // TODO - sdk_empty_survey_list
          }
          
        }
        
      case .failed(let error):
        //do nothing
        SOPLog.error(message: "error = \(error.localizedDescription)")
      }
    })
    
  }
  
  func closeButtonTapped(_ sender:AnyObject){
    dismiss(animated: false, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: SurveyListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SurveyListTableViewCell
    cell.surveyNo.text? = (self.showListItem[indexPath.row] as SurveyListItem).surveyIdLabel!
    cell.loi.text? = (self.showListItem[indexPath.row] as SurveyListItem).loi!
    if cell.loi.text != "" {
      cell.loi.text! += " min"
    }
    cell.titleName.text? = (self.showListItem[indexPath.row] as SurveyListItem).title!
    // TODO - get point value
//    let cookiePoint = profilingPointRule as! ProfilingPointRule
//    let pro = self.showListItem[0] as! Profiling
//    let point = cookiePoint.cookieProfilingPoint(profiling: pro)
    cell.pointLabel.text? = "10 each"
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("self.showListItem.count = \(self.showListItem.count)")
    return self.showListItem.count
  }
  
  func tableView(_ tableView: UITableView, commiteditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
  func showActivityIndicator(uiView: UIView) {
    self.indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    self.indicator!.center = (CGPoint(x: uiView.bounds.midX, y: uiView.bounds.midY))
    uiView.addSubview(self.indicator!)
    self.indicator!.startAnimating()
  }
  
  func hideActivityIndicator() {
    
    self.indicator?.stopAnimating()
  }
  
}
