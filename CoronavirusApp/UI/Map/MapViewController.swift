//
//  MapViewController.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/20/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    @IBOutlet weak var countryMap: UIView!
    
    var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: MapViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupMap()
    }

    func setupMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.latitude, longitude: viewModel.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
