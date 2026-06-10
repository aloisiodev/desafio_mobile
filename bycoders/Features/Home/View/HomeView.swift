//
//  HomeView.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @Binding var path: NavigationPath
    
    @EnvironmentObject private var sessionStore: SessionStore
    
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var locationService = LocationService()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if viewModel.region != nil {
                Map(
                    coordinateRegion: Binding(
                        get: {
                            viewModel.region!
                        },
                        set: {
                            viewModel.region = $0
                        }
                    ),
                    annotationItems: annotations
                ) { annotation in
                    MapAnnotation(coordinate: annotation.coordinate) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#0F62FE").opacity(0.25))
                                .frame(width: 44, height: 44)
                            
                            Circle()
                                .fill(Color(hex: "#0F62FE"))
                                .frame(width: 18, height: 18)
                        }
                    }
                }
                .ignoresSafeArea()
            } else if locationService.isPermissionDenied {
                ZStack {
                    Color(hex: "#161616")
                        .ignoresSafeArea()

                    VStack(spacing: 16) {
                        Image(systemName: "location.slash")
                            .font(.system(size: 48))
                            .foregroundStyle(.white)

                        Text("Permissão de localização negada")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .medium))

                        Text("Habilite nas Configurações do dispositivo")
                            .foregroundStyle(Color(hex: "#C6C6C6"))
                            .font(.system(size: 14))
                    }
                }
            } else if locationService.locationError != nil {
                ZStack {
                    Color(hex: "#161616")
                        .ignoresSafeArea()

                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 48))
                            .foregroundStyle(.orange)

                        Text("Erro ao obter localização")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .medium))

                        Button("Tentar novamente") {
                            locationService.requestCurrentLocation()
                        }
                        .foregroundStyle(Color(hex: "#78A9FF"))
                    }
                }
            } else {
                ZStack {
                    Color(hex: "#161616")
                        .ignoresSafeArea()

                    VStack(spacing: 16) {
                        ProgressView()
                            .tint(.white)

                        Text("Obtendo sua localização...")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                    }
                }
            }
            
            headerView
                .padding(.top, 16)
                .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            locationService.requestLocationPermission()
            locationService.requestCurrentLocation()
        }
        .onReceive(locationService.$currentLocation) { location in
            viewModel.updateLocation(location)
        }
    }
    
    private var annotations: [UserMapAnnotation] {
        guard let coordinate = viewModel.userCoordinate else {
            return []
        }
        
        return [
            UserMapAnnotation(coordinate: coordinate)
        ]
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Home")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)
                
                Text(sessionStore.currentUser?.email ?? "Usuário logado")
                    .font(.system(size: 13))
                    .foregroundStyle(Color(hex: "#C6C6C6"))
            }
            
            Spacer()
            
            Button {
                sessionStore.signOut()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.black.opacity(0.65))
            }
        }
        .padding(16)
        .background(Color(hex: "#161616").opacity(0.92))
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
        HomeView(path: $path)
            .environmentObject(SessionStore())
    }
}
