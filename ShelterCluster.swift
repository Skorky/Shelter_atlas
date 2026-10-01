//
//  ShelterCluster.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//
import Foundation
import MapKit

struct ShelterCluster: Identifiable {

    let id: String
    let shelters: [Shelter]
    let coordinate: CLLocationCoordinate2D

    var count: Int {
        shelters.count
    }

    var isSingleShelter: Bool {
        shelters.count == 1
    }

    var shelter: Shelter? {
        shelters.count == 1
        ? shelters.first
        : nil
    }
}

enum ShelterClusterer {

    static func makeClusters(
        shelters: [Shelter],
        region: MKCoordinateRegion
    ) -> [ShelterCluster] {

        // Při dostatečném přiblížení už clustering nepoužíváme.
        if region.span.latitudeDelta < 0.12 &&
            region.span.longitudeDelta < 0.16 {

            return shelters.map { shelter in
                ShelterCluster(
                    id: "shelter-\(shelter.id)",
                    shelters: [shelter],
                    coordinate: shelter.coordinate
                )
            }
        }

        // Mapa se rozdělí zhruba na mřížku.
        // Velikost buněk se automaticky mění podle zoomu.
        let latitudeStep = max(
            region.span.latitudeDelta / 10,
            0.005
        )

        let longitudeStep = max(
            region.span.longitudeDelta / 10,
            0.005
        )

        var buckets:
            [String: [Shelter]] = [:]

        for shelter in shelters {

            let coordinate =
                shelter.coordinate

            let latitudeIndex = Int(
                floor(
                    coordinate.latitude
                    / latitudeStep
                )
            )

            let longitudeIndex = Int(
                floor(
                    coordinate.longitude
                    / longitudeStep
                )
            )

            let key =
                "\(latitudeIndex)-\(longitudeIndex)"

            buckets[key, default: []]
                .append(shelter)
        }

        return buckets.map { key, shelters in

            let latitude =
                shelters
                .map {
                    $0.coordinate.latitude
                }
                .reduce(0, +)
                / Double(shelters.count)

            let longitude =
                shelters
                .map {
                    $0.coordinate.longitude
                }
                .reduce(0, +)
                / Double(shelters.count)

            return ShelterCluster(
                id: "cluster-\(key)",
                shelters: shelters,
                coordinate: CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                )
            )
        }
    }
}
