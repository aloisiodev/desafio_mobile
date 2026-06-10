//
//  MockLocalSessionRepository.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import CoreLocation
@testable import bycoders

final class MockLocalSessionRepository: LocalSessionRepositoring {
    private(set) var savedUser: AppUser?
    private(set) var savedCoordinate: CLLocationCoordinate2D?
    private(set) var updatedCoordinate: CLLocationCoordinate2D?

    func save(user: AppUser, coordinate: CLLocationCoordinate2D?) {
        savedUser = user
        savedCoordinate = coordinate
    }

    func updateCoordinate(_ coordinate: CLLocationCoordinate2D) {
        updatedCoordinate = coordinate
    }

    func fetchSession() -> UserSession? {
        return nil
    }
}
