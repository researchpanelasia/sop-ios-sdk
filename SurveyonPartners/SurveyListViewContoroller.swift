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
  
  @IBOutlet weak var transparentView: UIView!
  
  @IBOutlet weak var customView: UIView!
  
  @IBOutlet weak var emptyLabel: UILabel!
  
  static let FACEBOOK_Q_NAME = "q000_fb"
  
  static let GOOGLE_Q_NAME = "q000_ggl"
  
  static let COOKIE_Q_NAME = "q000_cookie"
  
  static let identifier: String = "SurveyListTableViewCell"
  
  var indicator: UIActivityIndicatorView?
  
  var showListItem: [SurveyListItem] = []
  
  var profilingPointRule: ProfilingPointRule?
  
  var researchPointRule: ResearchPointRule?
  
  func setRule(profilingPointRule: ProfilingPointRule, researchPointRule: ResearchPointRule) {
    self.profilingPointRule = profilingPointRule
    self.researchPointRule = researchPointRule
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let info = SurveyonPartners.getSetupInfo() else {
      //TODO: should throw error?
      return
    }
    
    emptyLabel.isHidden = true
    
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
            let languages = Locale.preferredLanguages.first
            var emptyMessage = "You\'ve completed all surveys for you. Don\'t worry, you will receive another survey soon."
            if languages!.hasPrefix("ko") {
              emptyMessage = "지금 참여 가능 설문조사가 없습니다. 곧 새로운 설문조사를 보내드리겠습니다."
            } else if languages!.hasPrefix("zh") {
              emptyMessage = "您已完成所有的問卷。不用擔心。您將會近期收到其他問卷。"
            } else if languages!.hasPrefix("id") {
              emptyMessage = "Anda telah menyelesaikan semua survei untuk Anda. Jangan kuatir, Anda akan menerima survei lagi segera."
            }
            self.emptyLabel.text =  emptyMessage
            self.emptyLabel.isHidden = false
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
    let cell: SurveyListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: SurveyListViewContoroller.identifier) as? SurveyListTableViewCell
    cell.surveyNo.text? = self.showListItem[indexPath.row].surveyIdLabel!
    cell.loi.text? = self.showListItem[indexPath.row].loi!
    if cell.loi.text != "" {
      cell.loi.text! += " min"
    }
    cell.titleName.text? = self.showListItem[indexPath.row].title!

    var point = ""
    if let _ = self.showListItem[indexPath.row] as? ImplProfiling {
      if self.showListItem[indexPath.row].surveyIdLabel == SurveyListViewContoroller.FACEBOOK_Q_NAME {
        point = profilingPointRule!.facebookAuthProfilingPoint(profiling: self.showListItem[indexPath.row] as! Profiling)
      } else if self.showListItem[indexPath.row].surveyIdLabel == SurveyListViewContoroller.GOOGLE_Q_NAME {
        point = profilingPointRule!.googleAuthProfilingPoint(profiling: self.showListItem[indexPath.row] as! Profiling)
      } else if self.showListItem[indexPath.row].surveyIdLabel == SurveyListViewContoroller.COOKIE_Q_NAME {
        point = profilingPointRule!.cookieProfilingPoint(profiling: self.showListItem[indexPath.row] as! Profiling)
      } else {
        point = profilingPointRule!.profilingPoint(profiling: self.showListItem[indexPath.row] as! Profiling)
      }
    } else if let _ = self.showListItem[indexPath.row] as? ImplResearch {
      point = researchPointRule!.researchPoint(research: self.showListItem[indexPath.row] as! Research)
    }
    cell.pointLabel.text? = point
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.showListItem.count
  }
  
  func tableView(_ tableView: UITableView, commiteditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let url = URL(string: self.showListItem[indexPath.row].url!)
    UIApplication.shared.openURL(url!)
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
