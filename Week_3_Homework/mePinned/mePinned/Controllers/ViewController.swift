//
//  ViewController.swift
//  mePinned
//
//  Created by Fahreddin Gölcük on 8.07.2021.
//

import UIKit
import MapKit
class ViewController: UIViewController {
    private var mapView: MKMapView!
    private var locationLabel: UILabel!
    private var locationPin: UIImage!
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation!
    
    private var addressObject: [String: String] = [:] //This object passed to other controller via NotificationCenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationPin = UIImage(systemName: "mappin.and.ellipse")
        let imageView = UIImageView(image: locationPin)
        imageView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        imageView.center = self.view.center
        imageView.layer.zPosition = 4
        self.view.addSubview(imageView)
        
        
        let addressButton = UIButton()
        addressButton.setTitle("OK", for: .normal)
        addressButton.backgroundColor = .red
        addressButton.frame = CGRect(x: 0, y: self.view.bounds.height - 60, width: 100, height: 50)
        addressButton.layer.zPosition = 4
        addressButton.addTarget(self, action: #selector(didTapAddressButton), for: .touchUpInside)
        addressButton.center.x = self.view.center.x
        addressButton.layer.cornerRadius = CGFloat(10)
        self.view.addSubview(addressButton)
        
        
        mapView = MKMapView()
        mapView.delegate = self
        mapView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 60)
        self.view.addSubview(mapView)
        
        
        checkLocationServices()
    }
    
    @objc private func didTapAddressButton(){
        let adressVC = AddressViewController()
        adressVC.addObserver()
        NotificationCenter.default.post(name: .Address, object: nil, userInfo: addressObject)
        present(adressVC, animated: true, completion: nil)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showUserLocationCenterMap(){
        if let location = locationManager.location?.coordinate {
            //MARK: User map information rectangle offset region.
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
            //MARK: Location services must open.
        }
    }
        
    func trackingLocation() {
        showUserLocationCenterMap()
        locationManager.startUpdatingLocation()
        lastLocation = getCenterLocation(mapView: mapView)
    }
    
    func getCenterLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }


}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authStatus = manager.authorizationStatus
        switch authStatus {
        case .authorizedWhenInUse:
            trackingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
            break
        default:
        break
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        guard let lastLocation = lastLocation else { return }
        guard center.distance(from: lastLocation) > 30 else { return }
        self.lastLocation = center
        
        geoCoder.reverseGeocodeLocation(center) {[weak self] (placemarks,error) in
            guard let self = self else { return }
            if let error = error {
                print(error)
                return
            }
            guard let placemark = placemarks?.first else { return }
            self.addressObject["locality"] = placemark.locality ?? "" //ilçe
            self.addressObject["street"] = placemark.thoroughfare ?? "" //sokak
            self.addressObject["country"] = placemark.country ?? "" // ülke
            self.addressObject["doorNumber"] = placemark.subThoroughfare ?? "" //KAPI NUMARASI
            self.addressObject["subLocality"] = placemark.subLocality ?? "" //mahalle
            self.addressObject["postalCode"] = placemark.postalCode ?? ""
            self.addressObject["city"] = placemark.administrativeArea ?? "" //ŞEHİR
        }
    }
}
