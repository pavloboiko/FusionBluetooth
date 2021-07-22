#if os(macOS) || os(iOS)
import FusionBluetooth_Common
import CoreBluetooth

public class BluetoothManager {
    fileprivate class CBCDelegate: NSObject {
        typealias Receiver = (Peripheral?) -> Void
        var receiver: Receiver?
        var peripheralArray: [CBPeripheral] = []
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
	public func discoverDevice(receiver: @escaping (Peripheral?) -> Void) {
		self.delegate.receiver = receiver
		centralManager.scanForPeripherals(withServices: nil, options: nil)
	}
	
	public func connectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void) {	
		self.delegate.receiver = receiver
		if let peripheral = self.delegate.peripheralArray.first(where: { "($0.identifier)" == uuid }) {
            centralManager.connect(peripheral, options: nil)
        } else {
        	receiver?(nil)
        }
	}
	
	public func disconnectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void) {
		self.delegate.receiver = receiver
		if let peripheral = self.delegate.peripheralArray.first(where: { uuid == "($0.identifier)" }) {
            centralManager.cancelPeripheralConnection(peripheral)
        } else {
        	receiver?(nil)
        }
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
  
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
                      
      var state: PeripheralState = .disconnected
      switch peripheral.state {
      case .connected:
          state = .connected
      case .connecting:
          state = .connecting
      case .disconnected:
          state = .disconnected
      case .disconnecting:
          state = .disconnecting
      @unknown default:
          state = .disconnected
      }
      
      let peripheralData = Peripheral(name: peripheral.name, uuid: "\(peripheral.identifier)", state: state)
      if !self.peripheralArray.contains(peripheral) {
          self.peripheralArray.append(peripheral)

          receiver?(peripheralData)
      }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
	    receiver?(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnect peripheral: CBPeripheral) {
        receiver?(peripheral)
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