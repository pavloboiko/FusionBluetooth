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
		 if let bluetoothApdater = self.bluetoothAdapter, let activity = self.currentActivity {
		 	bluetoothAdapter.startDiscovery()
		 	activity.registerReceiver(bluetoothReceiver, IntentFilter(BluetoothDevice.ACTION_FOUND))
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
		if let intent = intent, let action = intent.getAction(), action == BluetoothDevice.ACTION_FOUND {
			let device: BluetoothDevice? = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE)
            let deviceName = device?.getName()
            let deviceHardwareAddress = device?.getAddress()
		}
    }
    
}

