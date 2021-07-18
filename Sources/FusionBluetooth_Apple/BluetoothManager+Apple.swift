#if os(macOS) || os(iOS)
import FusionBluetooth_Common
import CoreBluetooth

public class BluetoothManager {
    fileprivate class CBCDelegate: NSObject {
        typealias Receiver = (String?) -> Void
        var receiver: Receiver?
    }
  
	private let delegate: CBCDelegate
	private let centralManager: CBCentralManager
//	private let peripheral: CBPeripheral!
	private let peripheralArray: [CBPeripheral]
	
	public required init() {
		self.delegate = CBCDelegate()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        self.peripheralArray = []()
    }
	
}

extension BluetoothManager: BluetoothManagerProtocol {
	func discoverDevice(receiver: @escaping (String?) -> Void) {
		self.delegate.receiver = receiver
		centralManager.scanForPeripherals(withServices: nil, options: nil)
	}
	
	func connectDevice(address: String) {
		
	}
	
	func receiveMessage(message: @escaping (String) -> Void) {
		
	}
	
    func sendMessage(message: String) {
    	
    }
}

extension BluetoothManager.CBCDelegate: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unknown:
      print("central.state is .unknown")
    case .resetting:
      print("central.state is .resetting")
    case .unsupported:
      print("central.state is .unsupported")
    case .unauthorized:
      print("central.state is .unauthorized")
    case .poweredOff:
      print("central.state is .poweredOff")
    case .poweredOn:
      print("central.state is .poweredOn")
    }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                      advertisementData: [String : Any], rssi RSSI: NSNumber) {	
	  receiver(peripheral.name)
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
  
  }
}

extension BluetoothManager.CBCDelegate: CBPeripheralDelegate {
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {

  }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
  
  }

  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
  }
}


#endif