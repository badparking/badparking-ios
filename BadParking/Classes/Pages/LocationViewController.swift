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
    var firstLocationUpdate = false
    let geocoder = GMSGeocoder.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.index = 1
        
        self.mapView.settings.compassButton = true
        self.mapView.delegate = self
        self.mapView.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
        
        DispatchQueue.main.async {
            self.mapView.isMyLocationEnabled = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if firstLocationUpdate == false {
            firstLocationUpdate = true
            let location = change?[.newKey] as! CLLocation
            mapView.camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        }
    }
    
    deinit {
        self.mapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    // MARK: Google Maps Delegate
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let coordinate = mapView.projection.coordinate(for: mapView.center)
        geocoder.reverseGeocodeCoordinate(coordinate) { (response: GMSReverseGeocodeResponse?, error: Error?) in
            let address = response?.firstResult()
            self.addressView.text = address?.lines?.joined(separator: ", ")
        }
    }

    // MARK: - IBActions
    
    @IBAction func showUserLocation(_ sender: UIButton) {
        self.mapView.animate(toLocation: mapView.myLocation!.coordinate)
    }
    
}
