import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    // UI Элементы
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "🔍 Поиск города..."
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 12
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.layer.shadowOffset = CGSize(width: 0, height: 2)
        tf.layer.shadowOpacity = 0.1
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Найти", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let zoomInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let zoomOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupLocation()
        setupButtons()
        setupSearch()
        addAnnotations()
    }
    
    private func setupMap() {
        mapView.frame = view.bounds
        mapView.delegate = self
        view.addSubview(mapView)
        
        // Центр на Минске и Европе
        let center = CLLocationCoordinate2D(latitude: 53.9, longitude: 27.5667)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
        
        // Включаем все жесты
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    private func setupButtons() {
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        
        NSLayoutConstraint.activate([
            zoomInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zoomInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            zoomInButton.widthAnchor.constraint(equalToConstant: 60),
            zoomInButton.heightAnchor.constraint(equalToConstant: 60),
            
            zoomOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zoomOutButton.bottomAnchor.constraint(equalTo: zoomInButton.topAnchor, constant: -10),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 60),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
    }
    
    private func setupSearch() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        searchButton.addTarget(self, action: #selector(searchCity), for: .touchUpInside)
    }
    
    @objc private func zoomIn() {
        var region = mapView.region
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func zoomOut() {
        var region = mapView.region
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func searchCity() {
        guard let query = searchTextField.text, !query.isEmpty else { return }
        searchTextField.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                let alert = UIAlertController(title: "Город не найден", message: "Попробуйте ещё раз", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                return
            }
            
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            self?.mapView.setRegion(region, animated: true)
        }
    }
    
    private func addAnnotations() {
        let airports: [(String, Double, Double)] = [
            ("Минск", 53.9022, 27.5618),
            ("Киев", 50.4501, 30.5234),
            ("Вильнюс", 54.6872, 25.2797),
            ("Смоленск", 54.7820, 32.0453)
        ]
        
        for airport in airports {
            let annotation = MKPointAnnotation()
            annotation.title = airport.0
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.1, longitude: airport.2)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showActions(for city: String) {
        let alert = UIAlertController(title: city, message: "Выберите действие", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "✈️ Рейсы из Минска", style: .default) { [weak self] _ in
            let flightsVC = FlightsViewController(city: city)
            self?.navigationController?.pushViewController(flightsVC, animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "🌤 Погода", style: .default) { [weak self] _ in
            self?.showWeather(for: city)
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    private func showWeather(for city: String) {
        let alert = UIAlertController(title: "Загрузка", message: "Получаем погоду для \(city)...", preferredStyle: .alert)
        present(alert, animated: true)
        
        WeatherService.shared.getWeather(for: city) { weather in
            DispatchQueue.main.async {
                alert.dismiss(animated: true) {
                    let result = UIAlertController(title: "🌤 Погода в \(city)", message: weather ?? "Не удалось получить данные", preferredStyle: .alert)
                    result.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(result, animated: true)
                }
            }
        }
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if annotation is MKUserLocation {
            return
        }
        if let pointAnnotation = annotation as? MKPointAnnotation,
           let city = pointAnnotation.title {
            showActions(for: city)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "AirportPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            marker.markerTintColor = .systemBlue
            marker.glyphImage = UIImage(systemName: "airplane")
            annotationView = marker
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}
