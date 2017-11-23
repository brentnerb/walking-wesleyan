//
//  ViewController.swift
//  Walking Wesleyan
//
//  Created by Brent Morgan on 6/8/17.
//  Copyright © 2017 Brent Morgan. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    
    fileprivate let locationManager = CLLocationManager()
//    fileprivate var startedLoadingPOIs = false
    fileprivate var places = [Place]()
    fileprivate var arViewController: ARViewController!
    
    var groups = [Group]()
    
//    var infoView: ARAnnotationView?
    
    var myHouse = Place(name: "My House", location: CLLocation(latitude: 41.551379, longitude: -72.665369), moreInfo: "The one with the red door. Stop by and say hello!", address: "260 Cross Street", website: nil)
    var myParentsHouse = Place(name: "My Parents' House", location: CLLocation(latitude: 41.549560, longitude: -72.654291), moreInfo: "Go away!", address: "46 Beach Street", website: nil)
    var high = Place(name: "Liberty Bank", location: CLLocation(latitude: 41.550322, longitude: -72.654564), moreInfo: "Office park, Liberty Bank, etc.", address: "55 High Street", website: nil)
    var neighbor = Place(name: "My Parents' Neighbor's House", location: CLLocation(latitude: 41.549770, longitude: -72.653504), moreInfo: "Good fences make good neighbors.", address: "31 High Street", website: nil)
    var neighbor2 = Place(name: "My Parents' Neighbor's House", location: CLLocation(latitude: 41.549588, longitude: -72.654850), moreInfo: "Good fences make good neighbors. Trees also help.", address: "1 Beach Street", website: nil)
    
    var allb = Place(name: "Allbritton Center", location: CLLocation(latitude: 41.554202, longitude: -72.655978), moreInfo: "The Allbritton Center houses the Quantatative Analysis Center, the Shapiro Writing Center, and the Patricelli Thingabmajig for Public Life or something", address: "222 Church Street", website: nil)
    var esc = Place(name: "Exley Science Center", location: CLLocation(latitude: 41.553295, longitude: -72.657257), moreInfo: "Exley Science Center was constructed in 1958, funded primarily by Cornelius Exley, '45, who made is fortune in auto parts manufacture after graduating with a degree in Engineering from Wesleyan. It is home to Tishler Lecture Hall, the largest teaching space on campus, as well as many other classrooms and laboratories.", address: "265 Church Street", website: nil)
    var judd = Place(name: "Judd Hall", location: CLLocation(latitude: 41.554917, longitude: -72.655950), moreInfo: "Here is where all the Psychology happens. Its very psychological indeed.", address: "207 High Street", website: nil)
    var pac = Place(name: "Public Affairs Center", location: CLLocation(latitude: 41.554685, longitude: -72.656481), moreInfo: "So much public!! So much public!! So much public!! So much public!! So much public!! So much public!!", address: "268 Church Street", website: nil)
    var usdan = Place(name: "Usdan University Center", location: CLLocation(latitude: 41.556765, longitude: -72.656809), moreInfo: "asdf asdf asdf adfg asdf ad adsf ads fadsf asd fasd fasdf asdf asdf asdf asdfasdf asdf asd fadfas d fasdf asdf asdfsadsfasdf asdf asdfadsf asdf asd fad fadf ad fasa", address: "45 Wyllys Avenue", website: nil)
    var olin = Place(name: "Olin Memorial Library", location: CLLocation(latitude: 41.554552, longitude: -72.657155), moreInfo: "Wesleyan University has an extensive library collection, most of which is housed in Olin Memorial Library, which has more than 1.8 million volumes and approximately 10,000 serial subscriptions. Wesleyan's first library was Rich Hall (now '92 Theater), which was built just after the Civil War. Olin Library was designed by the firm of McKim, Mead, and White, built in 1925–27 and dedicated in 1928. Olin originally was much smaller and also contained classroom space. It has since been enlarged twice, the last time in 1992.", address: "252 Church Street", website: nil)
    var shan = Place(name: "Shanklin Laborarory", location: CLLocation(latitude: 41.553559, longitude: -72.656368), moreInfo: "No more info available.", address: "237 Church Street", website: nil)
    var ha = Place(name: "Hall-Atwater Laboratory", location: CLLocation(latitude: 41.553183, longitude: -72.656067), moreInfo: "No more info available.", address: "52 Lawn Avenue", website: nil)
    var patricelli = Place(name: "Patricalli Theatre", location: CLLocation(latitude: 41.555294, longitude: -72.656034), moreInfo: "No more info available.", address: "221 Church Street", website: nil)
    var zelnick = Place(name: "Zelnick Pavillion", location: CLLocation(latitude: 41.555461, longitude: -72.656180), moreInfo: "No more info available.", address: "207 High Street", website: nil)
    var chapel = Place(name: "Memorial Chapel", location: CLLocation(latitude: 41.555642, longitude: -72.656095), moreInfo: "No more info available.", address: "221 Church Street", website: nil)
    var sc = Place(name: "South College", location: CLLocation(latitude: 41.555993, longitude: -72.656151), moreInfo: "Administrative offices.", address: "229 High Street", website: nil)
    var nc = Place(name: "North College", location: CLLocation(latitude: 41.556306, longitude: -72.656162), moreInfo: "Administrative offices, including the Office of the President.", address: "237 High Street", website: nil)
    var andrus = Place(name: "Andrus Field", location: CLLocation(latitude: 41.555781, longitude: -72.657426), moreInfo: "No more info available.", address: "Wesleyan University", website: nil)
    var foss = Place(name: "Foss Hill", location: CLLocation(latitude: 41.555424, longitude: -72.658843), moreInfo: "No more info available.", address: "Wesleyan University", website: nil)
    var boger = Place(name: "Boger Hall", location: CLLocation(latitude: 41.556879, longitude: -72.656279), moreInfo: "Named for Joshua Boger ’73, P’06, P’09 and Dr. Amy Boger P’06, P’09 in recognition of the Boger family’s generosity and leadership.", address: "41 Wyllys Avenue", website: nil)
    var tree = Place(name: "Justin-Jinich Memorial Tree", location: CLLocation(latitude: 41.555221, longitude: -72.658393), moreInfo: "Dedicated in memory of Christina Justin-Jinich '10", address: "Foss Hill, Wesleyan University", website: nil)
    var fayerweather = Place(name: "Fayerweather", location: CLLocation(latitude: 41.556596, longitude: -72.657472), moreInfo: "Part of the Usdan complex, the Fayerweather building is home to Beckham Hall", address: "55 Wyllys Avenue", website: nil)
    var admissions = Place(name: "Office of Admissions", location: CLLocation(latitude: 41.556871, longitude: -72.658333), moreInfo: "No more info available.", address: "70 Wyllys Avenue", website: nil)
    var rh = Place(name: "Rehearsal Hall", location: CLLocation(latitude: 41.557221, longitude: -72.657177), moreInfo: "No more info available.", address: "60 Wyllys Avenue", website: nil)
    var wmh = Place(name: "World Music Hall", location: CLLocation(latitude: 41.557628, longitude: -72.656367), moreInfo: "No more info available.", address: "Wyllys Avenue", website: nil)
    var crowell = Place(name: "Crowell Concert Hall", location: CLLocation(latitude: 41.557508, longitude: -72.657178), moreInfo: "No more info available.", address: "Wesleyan University", website: nil)
    
    var clark1 = Place(name: "Clark North", location: CLLocation(latitude: 41.554765, longitude: -72.657822), moreInfo: "No more info available.", address: "268 Church Street", website: nil, memberOfGroup: "clark")
    var clark2 = Place(name: "Clark Entrance", location: CLLocation(latitude: 41.554511, longitude: -72.657842), moreInfo: "No more info available.", address: "268 Church Street", website: nil, memberOfGroup: "clark")
    var clark3 = Place(name: "Clark South", location: CLLocation(latitude: 41.554279, longitude: -72.657708), moreInfo: "No more info available.", address: "268 Church Street", website: nil, memberOfGroup: "clark")


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getStartedButton.layer.cornerRadius = 8
        
        places.append(myHouse)
        
        places.append(allb)
        places.append(esc)
        places.append(judd)
        places.append(pac)
        places.append(usdan)
        places.append(olin)
        places.append(shan)
        places.append(ha)
        places.append(patricelli)
        places.append(zelnick)
        places.append(chapel)
        places.append(sc)
        places.append(nc)
        places.append(andrus)
        places.append(foss)
        places.append(boger)
        places.append(tree)
        places.append(fayerweather)
        places.append(admissions)
        places.append(rh)
        places.append(wmh)
        places.append(crowell)
//        places.append(myParentsHouse)
//        places.append(high)
//        places.append(neighbor)
        places.append(clark1)
        places.append(clark2)
        places.append(clark3)
        
        for place in places {
            
            if place.memberOfGroup != nil {
                
                for group in groups {
                    
                    var groupAlreadyExists = false
                    
                    if group.name == place.memberOfGroup {
                        groupAlreadyExists = true
                    }
                }
                
            }
            
        }
    
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func getStartedAction(_ sender: Any) {
        
        print("Get Started")
        
        arViewController = ARViewController()
        arViewController.dataSource = self
        arViewController.maxVisibleAnnotations = 30
        arViewController.headingSmoothingFactor = 0.05
        arViewController.setAnnotations(places)
    
        self.present(arViewController, animated: true, completion: nil)
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")
            print("\(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            if location.horizontalAccuracy < 100 {
                
                manager.stopUpdatingLocation()
                
//                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
//                let region = MKCoordinateRegion(center: location.coordinate, span: span)
//                mapView.region = region
                
            }
        }
    }
}

extension ViewController: ARDataSource {
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = AnnotationView()
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
        annotationView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        annotationView.layer.cornerRadius = 10
        
        return annotationView
    }
}

extension ViewController: AnnotationViewDelegate {
    
    func didTouch(annotationView: ARAnnotationView) {

//        print("Tapped view for POI: \(annotationView.description)")
    }
    
}










