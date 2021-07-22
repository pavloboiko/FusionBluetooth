#if os(macOS) || os(iOS)
import FusionBluetooth_Common
import CoreBluetooth

public class BluetoothManager {
    fileprivate class CBCDelegate: NSObject {
        typealias Receiver = (Peripheral?) -> Void
        typealias StateReceiver = (CentralState) -> Void
        var receiver: Receiver?
        var stateReceiver: StateReceiver?
        
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
	public var isScanning = false
	
	public func checkState(receiver: @escaping (CentralState) -> Void) {
		self.delegate.stateReceiver = receiver
		var state: CentralState = .unknown
		switch centralManager.state {
        case .unknown:
          state = .unknown
        case .resetting:
          state = .resetting
        case .unsupported:
          state = .unsupported
        case .unauthorized:
          state = .unauthorized
        case .poweredOff:
          state = .poweredOff
        case .poweredOn:
          state = .poweredOn

        @unknown default:
          state = .unknown
        }
        
        receiver(state)
	}
	
	public func discoverDevice(receiver: @escaping (Peripheral?) -> Void) {
		self.delegate.receiver = receiver
		centralManager.scanForPeripherals(withServices: nil, options: nil)
	}
	
	public func stopDicovering() {
		centralManager.stopScan()
	}
	
	public func connectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void) {	
		self.delegate.receiver = receiver
		if let peripheral = self.delegate.peripheralArray.first(where: { "\($0.identifier)" == uuid }) {
            centralManager.connect(peripheral, options: nil)
        } else {
        	receiver(nil)
        }
	}
	
	public func disconnectDevice(uuid: String, receiver: @escaping (Peripheral?) -> Void) {
		self.delegate.receiver = receiver
		if let peripheral = self.delegate.peripheralArray.first(where: { uuid == "\($0.identifier)" }) {
            centralManager.cancelPeripheralConnection(peripheral)
        } else {
        	receiver(nil)
        }
	}
	
	public func receiveMessage(message: @escaping (String) -> Void) {
		
	}
	
    public func sendMessage(message: String) {
    	
    }
}

extension BluetoothManager.CBCDelegate: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
		var state: CentralState = .unknown
		switch centralManager.state {
        case .unknown:
          state = .unknown
        case .resetting:
          state = .resetting
        case .unsupported:
          state = .unsupported
        case .unauthorized:
          state = .unauthorized
        case .poweredOff:
          state = .poweredOff
        case .poweredOn:
          state = .poweredOn

        @unknown default:
          state = .unknown
        }
        
        stateReceiver?(state)
    }
  
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
	  let peripheralData = self.convertPeripheral(peripheral: peripheral)
      if !self.peripheralArray.contains(peripheral) {
          self.peripheralArray.append(peripheral)

          receiver?(peripheralData)
      }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
	    let peripheralData = self.convertPeripheral(peripheral: peripheral)
	    receiver?(peripheralData)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
	    let peripheralData = self.convertPeripheral(peripheral: peripheral)
        receiver?(peripheralData)
    }
    
    private func convertPeripheral(peripheral: CBPeripheral) -> Peripheral{
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
        
        return Peripheral(name: peripheral.name, uuid: "\(peripheral.identifier)", state: state)
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