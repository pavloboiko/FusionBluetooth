import Java
import Android
import AndroidOS
import AndroidApp
import AndroidBluetooth

public class BluetoothManager {
	typealias BluetoothAdapter = AndroidBluetooth.BluetoothAdapter

	private var currentActivity: Activity? { Application.currentActivity }
 	
}

extension BluetoothManager: BluetoothManagerProtocol {

    public func isScanning() -> Bool{
    	
    }
    
	public func checkState(receiver: @escaping (CentralState) -> Void) {
		
	}
	
	public func discoverDevice(receiver: @escaping (Peripheral?) -> Void) {
		
	}
	
	public func stopDiscovering() {
		
	}
	
	public func connectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void) {
		
	}
	
	public func disconnectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void) {
		
	}
	
	public func receiveMessage(message: @escaping (String) -> Void) {
		
	}
	
    public func sendMessage(message: String) {
    	
    }
}



