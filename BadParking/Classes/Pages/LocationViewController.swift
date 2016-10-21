//
//  LocationViewController.swift
//  BadParking
//
//  Created by Eugene Nagorny on 9/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationViewController: BasePageViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressView: UITextView!

    var locationManager = CLLocationManager()

    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.index = 1
        
        checkLocationAuthorizationStatus()
        
        self.mapView.isMyLocationEnabled = true;
        self.mapView.delegate = self
//        locationManager.startUpdatingLocation()
    }

//    func centerMapOnLocation(location: CLLocation) {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
//                                                                  regionRadius * 2.0, regionRadius * 2.0)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

//    func geoCode(_ location : CLLocation!) {
//        /* Only one reverse geocoding can be in progress at a time hence we need to cancel existing
//         one if we are getting location updates */
//        let geoCoder = CLGeocoder()
//        geoCoder.cancelGeocode()
//        geoCoder.reverseGeocodeLocation(location) { (data, error) in
//            guard let placeMarks = data as [CLPlacemark]! else {
//                return
//            }
//            let loc: CLPlacemark = placeMarks[0]
//            let addressDict : [NSString:NSObject] = loc.addressDictionary as! [NSString: NSObject]
//            let addrList = addressDict["FormattedAddressLines"] as! [String]
//            let address = addrList.joined(separator: ", ")
//            self.addresView.text = address
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations.first!
//        self.mapView.centerCoordinate = location.coordinate
//        let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500, 1500)
//        self.mapView.setRegion(reg, animated: true)
//        geoCode(location)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        locationManager.stopUpdatingLocation()
//        let location = CLLocation(latitude: mapView.centerCoordinate.latitude,
//                                  longitude: mapView.centerCoordinate.longitude)
//        geoCode(location)
//    }

    @IBAction func showUserLocation(_ sender: UIButton) {
        if mapView.myLocation != nil {
            self.mapView.animate(toLocation: (mapView.myLocation?.coordinate)!)
        }
    }
    
}