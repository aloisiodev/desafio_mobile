//
//  LocationService.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Combine
import CoreLocation
import Foundation

protocol LocationServicing: ObservableObject {
    var currentLocation: CLLocation? { get }
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestLocationPermission()
    func requestCurrentLocation()
}

final class LocationService: NSObject, ObservableObject, LocationServicing {
    
    @Published private(set) var locationError: Error?
    @Published private(set) var currentLocation: CLLocation?
    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    
    var isPermissionDenied: Bool {
        authorizationStatus == .denied || authorizationStatus == .restricted
    }
    
    private let locationManager = CLLocationManager()
    
    override init() {
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestCurrentLocation() {
        locationManager.requestLocation()
    }
}


extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        locationError = error
    }
}
