//
//  LocationViewController.swift
//  BadParking
//
//  Created by Eugene Nagorny on 9/18/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationViewController: BasePageViewController, GMSMapViewDelegate {
    
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
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                let alert = UIAlertController (
                    title: "Увага",
                    message: "Для того що б показати вас на карті перейдіть у налаштування додатку і увімкніть доступ до геоданих",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction.init(title: "Заборонити", style: .default, handler: nil))
                alert.addAction(UIAlertAction.init(title: "Налаштування", style: .cancel, handler: { (acton: UIAlertAction) -> Void in
                    UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
                }))
                self.present(alert, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                self.mapView.animate(toLocation: mapView.myLocation!.coordinate)
            }
        } else {
            let alert = UIAlertController (
                title: "Увага",
                message: "Доступ до геоданих вимкнений, перейдіть в налаштування вашого пирстрою щоб увімкнути його",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction.init(title: "Добре", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
