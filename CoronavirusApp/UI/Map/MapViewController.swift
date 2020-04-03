//
//  MapViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/20/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMobileAds

class MapViewController: UIViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var mapView: GMSMapView!
    let viewModel = MapViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBannerView()
        viewModel.getCountryLocationArray { countryLocations in
            guard let countryLocations = countryLocations else { return }
            self.setupMap(withLocationMarker: countryLocations)
        }
    }

    // MARK: - Private methods
    private func setupBannerView() {
        bannerView.adUnitID = "ca-app-pub-5249500779728690/7158580074"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    private func setupMap(withLocationMarker locationMarkers: [CountryLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 3.0)
        mapView.camera = camera
        mapView.settings.zoomGestures = true
        setupMarkers(locationMarkers, inMap: mapView)
    }
    
    private func setupMarkers(_ locationMarkers: [CountryLocation], inMap map: GMSMapView) {
        for location in locationMarkers {
            let iconView = MarkerView(frame: CGRect(x: 0, y: 0,
                                                    width: location.markerSize,
                                                    height: location.markerSize))
            iconView.setupMarkerView()
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            marker.title = location.countryName
            marker.snippet = location.confirmedCases
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.iconView = iconView
            marker.map = map
        }
    }
}
