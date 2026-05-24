import Foundation

class FlightService {
    static let shared = FlightService()
    
    func getFlights(from: String, to: String) -> [String] {
        // Временные тестовые данные
        if from == "Минск" && to == "Киев" {
            return ["Belavia - 120 BYN", "Ukraine International - 135 BYN"]
        } else if from == "Минск" && to == "Вильнюс" {
            return ["Belavia - 100 BYN", "Air Baltic - 115 BYN"]
        } else if from == "Минск" && to == "Смоленск" {
            return ["Belavia - 80 BYN", "RusLine - 75 BYN"]
        }
        return []
    }
}
