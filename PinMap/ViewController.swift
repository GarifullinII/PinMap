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
    
    let addAddress: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addaddress"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let routeAddress: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "route"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetAddress: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reset"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var annotationsArray = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAddress.addTarget(self, action: #selector(addAddressTapped), for: .touchUpInside)
        routeAddress.addTarget(self, action: #selector(routeAddressTapped), for: .touchUpInside)
        resetAddress.addTarget(self, action: #selector(resetAddressTapped), for: .touchUpInside)
    }
    
    // MARK: - Add address
    
    @objc func addAddressTapped() {
        alertAddAddress(
            title: "Add",
            placeholder: "Add address") { (text) in
                self.setupPlaceMark(addressPlace: text)
            }
    }
    
    // MARK: - Route address
    
    @objc func routeAddressTapped() {
        print("Tap route")
    }
    
    // MARK: - Reset address
    
    @objc func resetAddressTapped() {
        print("Tap reset")
    }
    
    // MARK: - Place mark
    
    private func setupPlaceMark(addressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [self] (plasemarks, error) in
            
            if let error = error {
                print(error)
                alertError(
                    title: "Error",
                    message: "Error. Pleace write address!")
                return
            }
            
            guard let placemarks = plasemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(addressPlace)"
            
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 2 {
                routeAddress.isHidden = false
                resetAddress.isHidden = false
            }
            
            mapView.showAnnotations(annotationsArray, animated: true)
        }
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
        
        mapView.addSubview(addAddress)
        NSLayoutConstraint.activate([
            addAddress.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAddress.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAddress.heightAnchor.constraint(equalToConstant: 70),
            addAddress.widthAnchor.constraint(equalToConstant: 70),
        ])
        
        mapView.addSubview(routeAddress)
        NSLayoutConstraint.activate([
            routeAddress.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeAddress.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -60),
            routeAddress.heightAnchor.constraint(equalToConstant: 70),
            routeAddress.widthAnchor.constraint(equalToConstant: 70),
        ])
        
        mapView.addSubview(resetAddress)
        NSLayoutConstraint.activate([
            resetAddress.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetAddress.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -60),
            resetAddress.heightAnchor.constraint(equalToConstant: 70),
            resetAddress.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
}
