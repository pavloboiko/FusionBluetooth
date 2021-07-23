import Java
import Android
import AndroidOS
import AndroidApp
import AndroidContent
import AndroidBluetooth

import FusionBluetooth_Common

public class BluetoothManager {
	typealias BluetoothAdapter = AndroidBluetooth.BluetoothAdapter
	typealias BluetoothDevice = AndroidBluetooth.BluetoothDevice

	private var currentActivity: Activity? { Application.currentActivity }
	
	private let bluetoothAdapter: BluetoothAdapter? = nil
	
	private var bluetoothReceiver = BluetoothReceiver()	
	
	public required init() {  
		self.bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
	} 	
}

extension BluetoothManager: BluetoothManagerProtocol {

    public func isScanning() -> Bool {
    	if let bluetoothApdater = self.bluetoothAdapter {
    		return bluetoothApdater.isDiscovering()
    	} else {
    		return false
    	}
    }
    
	public func checkState(receiver: @escaping (CentralState) -> Void) {
		
	}
	
	public func discoverDevice(receiver: @escaping (Peripheral?) -> Void) {
		 if let apdater = self.bluetoothAdapter, let activity = self.currentActivity {
		 	apdater.startDiscovery()
		 	activity.registerReceiver(receiver:bluetoothReceiver, filter: IntentFilter(action: BluetoothDevice.ACTION_FOUND))
    	}
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

public class BluetoothReceiver: Object, BroadcastReceiver {
	static let shared = BluetoothReceiver()
	var receiver: ((Peripheral?) -> Void)?
	
	public func onReceive(context: Context?, intent: Intent?) {
		guard let action = intent?.getAction() else { return }
		if action == BluetoothDevice.ACTION_FOUND {
			guard let device = intent?.getParcelableExtra(name: BluetoothDevice.EXTRA_DEVICE) as? BluetoothDevice else { return }
            let deviceName = device.getName()
            let deviceHardwareAddress = device.getAddress()
            
            var state: PeripheralState = .disconnected
            if device.isConnected() {
            	state = .connected
            }
            
            let peripheral = Peripheral(name: deviceName, uuid: deviceHardwareAddress, state: state)
            receiver?(peripheral)
		}
    }
    
}

