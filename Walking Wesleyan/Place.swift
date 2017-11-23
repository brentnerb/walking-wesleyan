//
//  Place.swift
//  Walking Wesleyan
//
//  Created by Brent Morgan on 6/8/17.
//  Copyright © 2017 Brent Morgan. All rights reserved.
//

import Foundation
import CoreLocation

class Place: ARAnnotation {
    
    let moreInfo: String
    let placeName: String
    let address: String
//    var phoneNumber: String?
    var website: String?
    
    var memberOfGroup: String?
    
//    var infoText: String {
//        get {
//            var info = "Address: \(address)"
//            
//            if phoneNumber != nil {
//                info += "\nPhone: \(phoneNumber!)"
//            }
//            
//            if website != nil {
//                info += "\nweb: \(website!)"
//            }
//            return info
//        }
//    }
    
    init(name: String, location: CLLocation, moreInfo: String, address: String, website: String?, memberOfGroup: String?) {
        placeName = name
        self.moreInfo = moreInfo
        self.address = address
        self.website = website
        self.memberOfGroup = memberOfGroup
        
        super.init()
        
        self.location = location
    }
    
    init(name: String, location: CLLocation, moreInfo: String, address: String, website: String?) {
        placeName = name
        self.moreInfo = moreInfo
        self.address = address
        self.website = website
        self.memberOfGroup = nil
        
        super.init()
        
        self.location = location
    }
    
    override var description: String {
        return placeName
    }
}
