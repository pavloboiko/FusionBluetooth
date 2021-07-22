#if os(macOS) || os(iOS)
import FusionBluetooth_Common
import CoreBluetooth

public class BluetoothManager {
    fileprivate class CBCDelegate: NSObject {
        typealias Receiver = (Peripheral) -> Void
        var receiver: Receiver?
        private let peripheralArray: [CBPeripheral] = []
    }
  
	private let delegate: CBCDelegate
	private let centralManager: CBCentralManager
//	private let peripheral: CBPeripheral!	
	
	public required init() {
		self.delegate = CBCDelegate()
        self.centralManager = CBCentralManager(delegate: self.delegate, queue: nil)
    }
	
}

extension BluetoothManager: BluetoothManagerProtocol {
	public func discoverDevice(receiver: @escaping (Peripheral) -> Void) {
		self.delegate.receiver = receiver
		centralManager.scanForPeripherals(withServices: nil, options: nil)
	}
	
	public func connectDevice(address: String) {
		
	}
	
	public func receiveMessage(message: @escaping (String) -> Void) {
		
	}
	
    public func sendMessage(message: String) {
    	
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

        @unknown default:
            fatalError()
        }
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                      advertisementData: [String : Any], rssi RSSI: NSNumber) {	                      
      self.peripheralArray.append(peripheral)
	  receiver(peripheral)
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