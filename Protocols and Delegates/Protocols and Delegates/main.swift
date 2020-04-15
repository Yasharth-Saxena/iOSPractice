
protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport? // whoever(class/struct/enum) sets themselves as delegate must have the AdvancedLifeSupport protocol adopted
    
    
    /// why because doing so makes the emergencyCallHandler know that you know how to perform CPR
    /// no matter what your identity is
    
    func assessSituation() {
        print("Can you tell me what happened?")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
}

struct Paramedic: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("paramedic performs CPR")
    }
}

class Doctor: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("Doctor performs CPR")
    }
}

class Surgeon: Doctor {
    
    override func performCPR() {
        print("surgeon performs CPR while singing songs")
    }
}

let emilio = EmergencyCallHandler()
let john = Paramedic(handler: emilio)
let adrian = EmergencyCallHandler()
let pamela = Doctor(handler: adrian)
let champak = EmergencyCallHandler()
let raju = Surgeon(handler: champak)


emilio.medicalEmergency()
adrian.medicalEmergency()
champak.medicalEmergency()
