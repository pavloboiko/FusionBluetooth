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

    /*
     * @method isScanning:
     *
     * @discussion Whether or not the central is currently scanning.
     */
	func isScanning() -> Bool
	
	/*
     * @method checkState:
     *
     * @param receiver Returns the state of the central device.
     *
     * @discussion Reads the state of central device
     */     
	func checkState(receiver: @escaping (CentralState) -> Void)
	
	/*
     * @method discoverDevice:
     *
     * @param receiver Returns a Peripheral discovered.
     *
     * @discussion Discovers Peripherals.
     */
	func discoverDevice(receiver: @escaping (Peripheral?) -> Void)
	
	/*
     * @method stopDiscovering:
     *
     * @discussion Stops scanning peripherals.
     */
	func stopDiscovering()
	
	/*
     * @method connectDevice:
     *
     * @param uuid Peripheral identifier in iOS and Device Mac addres in Android 
     * @param receiver Returns the Peripheral connected.
     *
     * @discussion Connects a peripheral
     */
	func connectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void)
	
	/*
     * @method connectDevice:
     *
     * @param uuid Peripheral identifier in iOS and Device Mac addres in Android 
     * @param receiver Returns the Peripheral disconnected.
     *
     * @discussion Disconnects a peripheral
     */
	func disconnectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void)
	
	/*
     * @method receiveMessage:
     *
     * @param message A message string received
     *
     * @discussion Receives a message to a peripheral.
     */
	func receiveMessage(message: @escaping (String) -> Void)
	
	/*
     * @method sendMessage:
     *
     * @param message A message string to send
     *
     * @discussion Sends a message to a peripheral.
     */
    func sendMessage(message: String)
}
