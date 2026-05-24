import Foundation

// MARK: - Модель лекарства
struct Medicine: Codable {
    let name: String
    let imageName: String
    let description: String
    let composition: String
}

// MARK: - Сервис для загрузки данных
class MedicineDataService {
    static let shared = MedicineDataService()
    
    func loadMedicines() -> [Medicine] {
        // Проверяем, есть ли файл в Bundle
        guard let url = Bundle.main.url(forResource: "medicines", withExtension: "plist") else {
            print("🔴 Файл medicines.plist не найден в Bundle!")
            print("🔴 Bundle path: \(Bundle.main.bundlePath)")
            return getTestMedicines()
        }
        
        print("🟢 Найден medicines.plist по пути: \(url)")
        
        guard let data = try? Data(contentsOf: url) else {
            print("🔴 Не удалось прочитать данные из medicines.plist")
            return getTestMedicines()
        }
        
        let decoder = PropertyListDecoder()
        if let medicines = try? decoder.decode([Medicine].self, from: data) {
            print("🟢 Успешно загружено \(medicines.count) лекарств из plist")
            return medicines
        } else {
            print("🔴 Ошибка декодирования medicines.plist")
            return getTestMedicines()
        }
    }
    
    private func getTestMedicines() -> [Medicine] {
        return [
            Medicine(name: "Аспирин", imageName: "pill", description: "От головной боли", composition: "Ацетилсалициловая кислота"),
            Medicine(name: "Парацетамол", imageName: "pill", description: "Жаропонижающее", composition: "Парацетамол"),
            Medicine(name: "Нурофен", imageName: "pill", description: "Противовоспалительное", composition: "Ибупрофен")
        ]
    }
}
