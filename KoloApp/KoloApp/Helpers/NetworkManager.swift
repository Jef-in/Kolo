//
//  NetworkManager.swift
//  KoloApp
//
//  Created by Jefin on 11/05/22.
//


import Network

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    public func stop() {
        monitor.cancel()
    }
}
