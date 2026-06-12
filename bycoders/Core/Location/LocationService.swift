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

@MainActor
final class LocationService: NSObject, ObservableObject, LocationServicing {
    
    @Published private(set) var locationError: Error?
    @Published private(set) var currentLocation: CLLocation?
    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    
    var isPermissionDenied: Bool {
        authorizationStatus == .denied || authorizationStatus == .restricted
    }
    
    private let locationManager = CLLocationManager()
    private let crashlytics: CrashlyticsServicing

    override init() {
        self.authorizationStatus = locationManager.authorizationStatus
        self.crashlytics = CrashlyticsService()
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    init(crashlytics: CrashlyticsServicing) {
        self.authorizationStatus = locationManager.authorizationStatus
        self.crashlytics = crashlytics
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
}


extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.locationError = error
        crashlytics.record(error)
    }
}
