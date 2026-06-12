//
//  HomeView.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    @Binding var path: NavigationPath
    
    @StateObject private var viewModel: HomeViewModel
    @StateObject private var locationService = LocationService()

    init(path: Binding<NavigationPath>, sessionStore: SessionStore) {
        self._path = path
        self._viewModel = StateObject(wrappedValue: HomeViewModel(sessionStore: sessionStore))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            mapContent

            headerView
                .padding(.top, BCSpacing.lg)
                .padding(.horizontal, BCSpacing.lg)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            guard !isSimulatingLocationDenied else { return }
            locationService.requestLocationPermission()
            locationService.requestCurrentLocation()
        }
        .onReceive(locationService.$currentLocation) { location in
            viewModel.updateLocation(location)
        }
    }

    private var isSimulatingLocationDenied: Bool {
        LaunchArguments.simulateLocationDenied
    }

    @ViewBuilder
    private var mapContent: some View {
        if let region = viewModel.region, !isSimulatingLocationDenied {
            Map(
                coordinateRegion: Binding(
                    get: { viewModel.region ?? region },
                    set: { viewModel.region = $0 }
                ),
                annotationItems: annotations
            ) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    BCMapPin()
                }
            }
            .ignoresSafeArea()
        } else if locationService.isPermissionDenied || isSimulatingLocationDenied {
            BCErrorState(
                icon: "location.slash",
                title: "Permissão de localização negada",
                description: "Habilite nas Configurações do dispositivo"
            )
        } else if locationService.locationError != nil {
            BCErrorState(
                icon: "exclamationmark.triangle",
                iconColor: .orange,
                title: "Erro ao obter localização",
                actionLabel: "Tentar novamente"
            ) {
                locationService.requestCurrentLocation()
            }
        } else {
            ZStack {
                Color.BC.background.ignoresSafeArea()
                VStack(spacing: BCSpacing.lg) {
                    ProgressView().tint(Color.BC.textPrimary)
                    Text("Obtendo sua localização...")
                        .font(Font.BC.body)
                        .foregroundStyle(Color.BC.textPrimary)
                }
            }
        }
    }

    private var annotations: [UserMapAnnotation] {
        guard let coordinate = viewModel.userCoordinate else { return [] }
        return [UserMapAnnotation(coordinate: coordinate)]
    }

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: BCSpacing.xs) {
                Text("Home")
                    .font(Font.BC.cardTitle)
                    .foregroundStyle(Color.BC.textPrimary)

                Text(sessionStore.currentUser?.email ?? "Usuário logado")
                    .font(Font.BC.caption)
                    .foregroundStyle(Color.BC.textSecondary)
            }

            Spacer()

            Button {
                sessionStore.signOut()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(Color.BC.textPrimary)
                    .frame(width: BCSpacing.Component.iconTap, height: BCSpacing.Component.iconTap)
                    .background(Color.BC.overlay)
            }
            .accessibilityIdentifier("btn_logout")
        }
        .padding(BCSpacing.lg)
        .background(Color.BC.background.opacity(0.92))
    }
}

struct UserMapAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    HomePreview()
}

private struct HomePreview: View {

    @State private var path = NavigationPath()

    var body: some View {
        HomeView(path: $path, sessionStore: SessionStore())
            .environmentObject(SessionStore())
    }
}
