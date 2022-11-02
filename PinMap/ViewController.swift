//
//  ViewController.swift
//  PinMap
//
//  Created by Ildar Garifullin on 02/11/2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
}

extension ViewController {
    
    func setConstraints() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
