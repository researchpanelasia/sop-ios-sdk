//
//  SurveyonPartnersOverlayView.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

final public class SurveyonPartnersOverlayView: UIView {
  
  /// The background color of the overlay view
  public dynamic var color: UIColor? {
    get { return overlay.backgroundColor }
    set { overlay.backgroundColor = newValue }
  }
  
  /// The opacity of the overay view
  public dynamic var opacity: Float {
    get { return Float(overlay.alpha) }
    set { overlay.alpha = CGFloat(newValue) }
  }
  
  internal lazy var overlay: UIView = {
    let overlay = UIView(frame: .zero)
    overlay.backgroundColor = UIColor.black
    overlay.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    overlay.alpha = 0.7
    return overlay
  }()
  
  // MARK: - Inititalizers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View setup
  
  fileprivate func setupView() {
    
    // Self appearance
    self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.backgroundColor = UIColor.clear
    self.alpha = 0
    
    // Add subviews
    addSubview(overlay)
  }
  
}
