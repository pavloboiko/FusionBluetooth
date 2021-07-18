import Foundation


public protocol LocationManagerProtocol {
	func discoverDevice(receiver: @escaping (String) -> Void)
	func connectDevice(address: String)
	func receiveMessage(message: @escaping (String) -> Void)
    func sendMessage(message: String)
}
