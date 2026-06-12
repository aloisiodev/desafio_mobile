//
//  LocalSessionRepositoryTests.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Testing
import CoreData
import CoreLocation
@testable import bycoders

@MainActor
struct LocalSessionRepositoryTests {

    private func makeRepository() -> LocalSessionRepository {
        let container = NSPersistentContainer(name: "bycoders")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { _, error in
            if let error { fatalError("Failed to load store: \(error)") }
        }
        return LocalSessionRepository(context: container.viewContext)
    }

    @Test func save_persistsUserData() {
        let repository = makeRepository()
        let user = AppUser(id: "abc123", email: "test@test.com")

        repository.save(user: user, coordinate: nil)

        let session = repository.fetchSession()
        #expect(session?.id == "abc123")
        #expect(session?.email == "test@test.com")
    }

    @Test func save_withCoordinate_persistsLocation() {
        let repository = makeRepository()
        let user = AppUser(id: "abc123", email: "test@test.com")
        let coordinate = CLLocationCoordinate2D(latitude: -23.5, longitude: -46.6)

        repository.save(user: user, coordinate: coordinate)

        let session = repository.fetchSession()
        #expect(session?.lastLatitude == "-23.5")
        #expect(session?.lastLongitude == "-46.6")
    }

    @Test func updateCoordinate_updatesExistingSession() {
        let repository = makeRepository()
        let user = AppUser(id: "abc123", email: "test@test.com")
        repository.save(user: user, coordinate: nil)

        let coordinate = CLLocationCoordinate2D(latitude: -23.5, longitude: -46.6)
        repository.updateCoordinate(coordinate)

        let session = repository.fetchSession()
        #expect(session?.lastLatitude == "-23.5")
        #expect(session?.lastLongitude == "-46.6")
    }

    @Test func fetchSession_withNoData_returnsNil() {
        let repository = makeRepository()
        #expect(repository.fetchSession() == nil)
    }
}
