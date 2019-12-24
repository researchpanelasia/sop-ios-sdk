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
  
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  
  static let FACEBOOK_Q_NAME = "q000_fb"
  
  static let GOOGLE_Q_NAME = "q000_ggl"
  
  static let COOKIE_Q_NAME = "q000_cookie"
  
  static let identifier: String = "SurveyListTableViewCell"
  
  var showListItem: [SurveyListItem] = []
  
  var profilingPointRule: ProfilingPointRule?
  
  var researchPointRule: ResearchPointRule?
  
  func setRule(profilingPointRule: ProfilingPointRule, researchPointRule: ResearchPointRule) {
    self.profilingPointRule = profilingPointRule
    self.researchPointRule = researchPointRule
  }
  
    @objc func movedToForeground() {
    showListItem.removeAll()
    tableView.reloadData()
    loadSurveyList()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    closeView.image = SurveyonPartners.getImage(name: "icon-close.png")

    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(movedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    loadSurveyList()
  }
  
  func loadSurveyList() {
    indicator.style = .whiteLarge
    indicator.color = UIColor.gray
    indicator.isHidden = false
    
    emptyLabel.isHidden = true
    
    customView.layer.cornerRadius = 5
    
    tableView.register(UINib(nibName: "SurveyListTableViewCell", bundle: SurveyonPartners.getResourceBundle()), forCellReuseIdentifier: "SurveyListTableViewCell")
    tableView.separatorStyle = .none
    tableView.backgroundColor = UIColor.clear
    
    closeView.isUserInteractionEnabled = true
    closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SurveyListViewContoroller.closeButtonTapped)))

    SurveyonPartners.getSurveyList(completion: { (result: RequestResult) -> Void in
      switch result {
      case .success(let response):
        SOPLog.debug(message: "statusCode = \(response)")

        self.showListItem = try! SurveyListItemFactory.create(data: response.data!).filter({ !$0.isMobileBlocked()})
        DispatchQueue.main.async {
          self.indicator.isHidden = true
          if self.showListItem.count > 0 {
            self.tableView.reloadData()
          } else {
            if let bundle = SurveyonPartners.getResourceBundle() {
                self.emptyLabel.text = NSLocalizedString("label_no_survey", bundle: bundle, comment: "")
            } else {
                self.emptyLabel.text = "No survey"
            }
            self.emptyLabel.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1.0)
            self.emptyLabel.isHidden = false
          }
        }
      case .failed(let error):
        SOPLog.error(message: "error = \(error)")
        DispatchQueue.main.async {
          self.dismiss(animated: false, completion: nil)
        }
      }
    })
  }
  
    @objc func closeButtonTapped(_ sender:AnyObject){
    dismiss(animated: false, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SurveyListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: SurveyListViewContoroller.identifier) as? SurveyListTableViewCell
    cell.surveyNo.text? = self.showListItem[indexPath.row].surveyIdLabel
    cell.loi.text? = self.showListItem[indexPath.row].loi
    if cell.loi.text != "" {
      cell.loi.text! += " min"
    }
    cell.titleName.text? = self.showListItem[indexPath.row].title

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
  
    func tableView(_ tableView: UITableView, commiteditingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let url = URL(string: self.showListItem[indexPath.row].url)
    UIApplication.shared.openURL(url!)
  }
}
