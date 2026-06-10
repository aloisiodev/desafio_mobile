//
//  LocalSessionRepository.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import CoreData
import CoreLocation

protocol LocalSessionRepositoring {
    func save(user: AppUser, coordinate: CLLocationCoordinate2D?)
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D)
    func fetchSession() -> UserSession?
}

final class LocalSessionRepository: LocalSessionRepositoring {
    static let shared = LocalSessionRepository()
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func save(user: AppUser, coordinate: CLLocationCoordinate2D?) {
        let session = fetchOrCreate()
        session.id = user.id
        session.email = user.email
        
        if let coordinate {
            session.lastLatitude = String(coordinate.latitude)
            session.lastLongitude = String(coordinate.longitude)
        }
        
        try? context.save()
        print("[CoreData] Saved user: \(user.email) at lat: \(coordinate?.latitude ?? 0), lon: \(coordinate?.longitude ?? 0)")
    }
    
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D) {
        guard let session = fetchSession() else { return }
        session.lastLatitude = String(coordinate.latitude)
        session.lastLongitude = String(coordinate.longitude)
        try? context.save()
        print("[CoreData] Updated coordinate: lat: \(coordinate.latitude), lon: \(coordinate.longitude)")
    }

    func fetchSession() -> UserSession? {
        let request = UserSession.fetchRequest()
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }
}

private extension LocalSessionRepository {
    func fetchOrCreate() -> UserSession {
        if let existing = fetchSession() {
            return existing
        }
        return UserSession(context: context)
    }
}
