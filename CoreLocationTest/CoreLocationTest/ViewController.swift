//
//  ViewController.swift
//  CoreLocationTest
//
//  Created by jin on 15/2/15.
//  Copyright (c) 2015 CS3217. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var lm: CLLocationManager!
    var geocoder: CLGeocoder!

    @IBOutlet weak var locationTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.lm = CLLocationManager()
        self.geocoder = CLGeocoder()

        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .NotDetermined {
                lm.requestWhenInUseAuthorization()
            }

            lm.startUpdatingLocation()

            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        }
    }

    func update() {
        let location = lm.location
        self.geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            let placemark = placemarks[0] as! CLPlacemark
            self.locationTextView.text = "\(placemark.name), \(placemark.ISOcountryCode)"
        } )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

