//
//  ViewController.swift
//  theMape
//
//  Created by Mladen Vidović on 01/11/2016.
//  Copyright © 2016 Mladen Vidović. All rights reserved.
//

import UIKit
import GoogleMaps




class LondonLocation: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}




class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: LondonLocation?
    
    let destinations = [LondonLocation(name: "Liverpool Street Station", location: CLLocationCoordinate2D(latitude: 51.518751, longitude: -0.081435), zoom: 15),
                        LondonLocation(name: "Gower St. Arran House", location: CLLocationCoordinate2D(latitude: 51.522177, longitude: -0.132480), zoom: 16),
                        LondonLocation(name: "Piccadilly Circus", location: CLLocationCoordinate2D(latitude: 51.510071, longitude: -0.134938), zoom: 16),
                        LondonLocation(name: "British Museum", location: CLLocationCoordinate2D(latitude: 51.519506, longitude: -0.126666), zoom: 16),
                        LondonLocation(name: "London Eye", location: CLLocationCoordinate2D(latitude: 51.503499, longitude: -0.118859), zoom: 16),
                        LondonLocation(name: "Tower Bridge", location: CLLocationCoordinate2D(latitude: 51.505476, longitude: -0.075399), zoom: 16),
                        LondonLocation(name: "Big Ben", location: CLLocationCoordinate2D(latitude: 51.500785, longitude: -0.124454), zoom: 16),
                        LondonLocation(name: "Jubilee Street", location: CLLocationCoordinate2D(latitude: 51.517240, longitude: -0.053016), zoom: 16)]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        GMSServices.provideAPIKey("AIzaSyB_-nuCcJtBBACxzlklFkeljWpW8oR0phU")
        
        let camera = GMSCameraPosition.camera(withLatitude: 51.886184, longitude: 0.238871, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
        
        let currentLocation = CLLocationCoordinate2D(latitude: 51.886184, longitude: 0.238871)
        let marker = GMSMarker(position: currentLocation)
        
        marker.title = "Stansted Airport"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextLoc))
    }

    func nextLoc () {
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.index(of: currentDestination!) {
                currentDestination = destinations[index + 1]
            }
        }
        setMapCamera()
    }

    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }

}













