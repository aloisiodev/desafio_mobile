//
//  HomeViewModel.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import Combine
import MapKit

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion?
    @Published var userCoordinate: CLLocationCoordinate2D?
    
    private let sessionStore: SessionStoring
    private let repository: LocalSessionRepositoring
    private let analytics: AnalyticsServicing
    private var hasLoggedMapRendered = false

    init(
        sessionStore: SessionStoring,
        repository: LocalSessionRepositoring = LocalSessionRepository.shared,
        analytics: AnalyticsServicing = AnalyticsService()
    ) {
        self.sessionStore = sessionStore
        self.repository = repository
        self.analytics = analytics
    }

    func updateLocation(_ location: CLLocation?) {
        guard let coordinate = location?.coordinate else { return }

        userCoordinate = coordinate
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )

        if let user = sessionStore.currentUser {
            repository.updateCoordinate(coordinate)

            if !hasLoggedMapRendered {
                analytics.logMapRendered(userId: user.id)
                hasLoggedMapRendered = true
            }
        }
    }
}
