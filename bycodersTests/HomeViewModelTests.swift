//
//  HomeViewModelTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
import CoreLocation
@testable import bycoders
internal import MapKit

@MainActor
struct HomeViewModelTests {

    @Test func updateLocation_withValidLocation_setsCoordinate() {
        let sessionStore = MockSessionStore()
        let repository = MockLocalSessionRepository()
        let viewModel = HomeViewModel(sessionStore: sessionStore, repository: repository)

        let location = CLLocation(latitude: -23.5, longitude: -46.6)
        viewModel.updateLocation(location)

        #expect(viewModel.userCoordinate != nil)
        #expect(viewModel.userCoordinate?.latitude == -23.5)
        #expect(viewModel.userCoordinate?.longitude == -46.6)
    }

    @Test func updateLocation_withValidLocation_setsRegion() {
        let sessionStore = MockSessionStore()
        let repository = MockLocalSessionRepository()
        let viewModel = HomeViewModel(sessionStore: sessionStore, repository: repository)

        let location = CLLocation(latitude: -23.5, longitude: -46.6)
        viewModel.updateLocation(location)

        #expect(viewModel.region != nil)
        #expect(viewModel.region?.center.latitude == -23.5)
        #expect(viewModel.region?.center.longitude == -46.6)
    }

    @Test func updateLocation_withNilLocation_doesNotSetCoordinate() {
        let sessionStore = MockSessionStore()
        let repository = MockLocalSessionRepository()
        let viewModel = HomeViewModel(sessionStore: sessionStore, repository: repository)

        viewModel.updateLocation(nil)

        #expect(viewModel.userCoordinate == nil)
        #expect(viewModel.region == nil)
    }

    @Test func updateLocation_savesCoordinateToRepository() {
        let sessionStore = MockSessionStore()
        let repository = MockLocalSessionRepository()
        let viewModel = HomeViewModel(sessionStore: sessionStore, repository: repository)

        let location = CLLocation(latitude: -23.5, longitude: -46.6)
        viewModel.updateLocation(location)

        #expect(repository.updatedCoordinate != nil)
        #expect(repository.updatedCoordinate?.latitude == -23.5)
    }
}
