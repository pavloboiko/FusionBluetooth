import Foundation

 public enum CentralState : String {
    case unknown = "Unknown"

    case resetting = "Resetting"

    case unsupported = "Unsupported"

    case unauthorized = "Unauthorized"

    case poweredOff = "Powered Off"

    case poweredOn = "Powered On"
}

  
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
	func isScanning() -> Bool
	func checkState(receiver: @escaping (CentralState) -> Void)
	func discoverDevice(receiver: @escaping (Peripheral?) -> Void)
	func stopDiscovering()
	func connectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void)
	func disconnectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void)
	func receiveMessage(message: @escaping (String) -> Void)
    func sendMessage(message: String)
}
