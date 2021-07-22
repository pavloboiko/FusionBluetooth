import Foundation

public enum PeripheralState : String {
    case disconnected = "Disconnected"
    case connecting = "Connecting"
    case connected = "Connected"
    case disconnecting = "Disconnecting"
}

public struct Peripheral: Equatable {
    public let name: String?
    public let uuid: String
    public var state: PeripheralState
    
    public init(name: String?, uuid: String, state: PeripheralState) {
        self.name = name
        self.uuid = uuid
        self.state = state
    }
}

public protocol BluetoothManagerProtocol {
	func discoverDevice(receiver: @escaping (Peripheral) -> Void)
	func connectDevice(address: String)
	func receiveMessage(message: @escaping (String) -> Void)
    func sendMessage(message: String)
}
