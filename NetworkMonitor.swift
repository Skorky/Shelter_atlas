//
//  NetworkMonitor.swift
//  Ukryty
//
//  Created by Petr Skorkovsky on 01.10.2026.
//
import Foundation
import Combine
import Network

@MainActor
final class NetworkMonitor: ObservableObject {

    @Published private(set) var isConnected = true
    @Published private(set) var interfaceType: NWInterface.InterfaceType?

    private let monitor = NWPathMonitor()

    private let queue = DispatchQueue(
        label: "NetworkMonitor"
    )

    init() {

        monitor.pathUpdateHandler = { [weak self] path in

            Task { @MainActor [weak self] in

                guard let self else {
                    return
                }

                self.isConnected =
                    path.status == .satisfied

                if path.usesInterfaceType(.wifi) {

                    self.interfaceType = .wifi

                } else if path.usesInterfaceType(.cellular) {

                    self.interfaceType = .cellular

                } else if path.usesInterfaceType(.wiredEthernet) {

                    self.interfaceType = .wiredEthernet

                } else {

                    self.interfaceType = nil
                }
            }
        }

        monitor.start(
            queue: queue
        )
    }

    deinit {
        monitor.cancel()
    }

    var statusTitle: String {

        isConnected
            ? "Online"
            : "Offline"
    }

    var statusSymbol: String {

        isConnected
            ? "network"
            : "wifi.slash"
    }

    var connectionDescription: String {

        guard isConnected else {
            return "Bez připojení k internetu"
        }

        switch interfaceType {

        case .wifi:
            return "Připojeno přes Wi-Fi"

        case .cellular:
            return "Připojeno přes mobilní síť"

        case .wiredEthernet:
            return "Připojeno přes Ethernet"

        default:
            return "Připojeno k internetu"
        }
    }
}
