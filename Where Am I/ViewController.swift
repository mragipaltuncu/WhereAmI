//
//  ViewController.swift
//  Where Am I
//
//  Created by Mehmet Ragıp Altuncu on 09/02/16.
//  Copyright © 2016 MehmetAltuncu. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    var manager : CLLocationManager!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        
        var userLocation:CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        self.altitudeLabel.text = "\(userLocation.altitude)"

        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else{
                
                if let p =  placemarks?[0] {
                    
                    var subThoroughfare: String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                    }
                    
                    self.adressLabel.text = "\(p.subThoroughfare)  \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                    
                }
            }
        }
        
        
        
        
        
        
        
        
    }

  

}

