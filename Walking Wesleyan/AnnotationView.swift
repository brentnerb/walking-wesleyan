//
//  AnnotationView.swift
//  Places
//
//  Created by Brent Morgan on 6/7/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

protocol AnnotationViewDelegate {
  func didTouch(annotationView: ARAnnotationView)
}

class AnnotationView: ARAnnotationView {
  
  var titleLabel: UILabel?
  var distanceLabel: UILabel?
    var infoLabel: UILabel?
  var delegate: AnnotationViewDelegate?
    
//    static var currentInfoLabel: UILabel?   // So we only have one infoLabel showing at a time.
    static var selectedAnnotationView: AnnotationView?
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    loadUI()
    
  }
  
  func loadUI() {
    
    titleLabel?.removeFromSuperview()
    distanceLabel?.removeFromSuperview()
    
    let label = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30))
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 0
    label.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    label.textColor = UIColor.white
    self.addSubview(label)
    self.titleLabel = label
    
    distanceLabel = UILabel(frame: CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20))
    distanceLabel?.backgroundColor = UIColor(white: 0.3, alpha: 0.7)
    distanceLabel?.textColor = .green
    distanceLabel?.font = UIFont.systemFont(ofSize: 12)
    self.addSubview(distanceLabel!)
    
    if let annotation = annotation as? Place {
      titleLabel?.text = " \(annotation.placeName)"
      let miles = annotation.distanceFromUser * 0.621371
        if (miles / 1000) < 0.5 {
            let feet = Int((miles / 1000) * 5280)
            distanceLabel?.text = " \(feet) Feet"
        } else {
            distanceLabel?.text = String(format: " %.2f Miles", miles / 1000)
        }
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel?.frame = CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30)
    distanceLabel?.frame = CGRect(x: 10, y: 30, width: self.frame.size.width, height: 20)
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    

    
    if AnnotationView.selectedAnnotationView != nil {
        AnnotationView.selectedAnnotationView?.infoLabel?.removeFromSuperview()     // If there is an infoLabel showing it will be removed, wether its MINE or a different instance's
    }
    
    AnnotationView.selectedAnnotationView = self
    
    delegate?.didTouch(annotationView: self)
    if let place = annotation as? Place {
        
        if infoLabel != nil {
//            infoLabel?.removeFromSuperview()          // I'm not sure but I don't think we need this because its being removed from view by the Class-level static method
            infoLabel = nil                             // still need to set it to nil though
            AnnotationView.selectedAnnotationView = nil     // Since infoLabel was not nil, meaning MY infoLabel was live, we can set the Class-level one to nil
        } else {
            // Add new infoLabel
            
//            if place.memberOfGroup != nil {
//                
//                for member in window?.rootViewController.
//                
//            }
            
            // To start out we'll give the infoLabel and approximate size and position, then re-size and position it once the text has been added.
            infoLabel = UILabel(frame: CGRect(x: 20, y: ((window?.bounds.height)! - 160), width: ((window?.bounds.width)! - 40), height: 140))
            infoLabel?.textColor = .white
            infoLabel?.backgroundColor = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.3)
            infoLabel?.font = UIFont.systemFont(ofSize: 16)
            infoLabel?.numberOfLines = 0
            infoLabel?.layer.cornerRadius = 8
            infoLabel?.clipsToBounds = true
            infoLabel?.textAlignment = .center
            infoLabel?.text = "\n    \(place.placeName)\n   \(place.address)  "
            if let url = place.website {
                infoLabel?.text?.append("\n   \(url)   ")
            }
            infoLabel?.text?.append("\n\n  \(place.moreInfo)    \n")
            
            super.window?.addSubview(infoLabel!)
            infoLabel?.sizeToFit()
            
            // Now re-size and position it
            let infoHeight = CGFloat((infoLabel?.bounds.size.height)!)
            let infoWidth = CGFloat((infoLabel?.bounds.size.width)!)
            
            infoLabel?.frame = CGRect(x: (((window?.bounds.width)! - infoWidth) / 2), y: ((window?.bounds.height)! - infoHeight - 20), width: infoWidth, height: infoHeight)

            // Finally set the timer to remove it from the view after 15 seconds
            let _ = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(AnnotationView.goAway), userInfo: infoLabel, repeats: false)
        }
    }
    
  }
    
    func goAway(sender: Timer) {
        if let il = sender.userInfo as? UILabel {
            il.removeFromSuperview()
            self.infoLabel = nil
            AnnotationView.selectedAnnotationView = nil
        }
    }
  
}




