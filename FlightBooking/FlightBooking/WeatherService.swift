import Foundation

class WeatherService {
    static let shared = WeatherService()
    private let apiKey = "4fe5286dd3007aecfb4e73570fc4a347"  // Добавлены кавычки!
    
    func getWeather(for city: String, completion: @escaping (String?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=ru"
        
        print("🌤 Запрос погоды для: \(city)")
        print("🔗 URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("❌ Неверный URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Ошибка сети: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("❌ Нет данных")
                completion(nil)
                return
            }
            
            // Печатаем ответ для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 Ответ от сервера: \(jsonString)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double {
                    
                    let weatherText = "🌡 \(Int(temp))°C"
                    print("✅ Погода получена: \(weatherText)")
                    completion(weatherText)
                } else {
                    print("❌ Не удалось распарсить JSON")
                    completion(nil)
                }
            } catch {
                print("❌ Ошибка парсинга: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
