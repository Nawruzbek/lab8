import UIKit

class FlightsViewController: UIViewController {
    
    private let city: String
    private var flights: [String] = []
    
    private let tableView = UITableView()
    
    init(city: String) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Минск → \(city)"
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        flights = FlightService.shared.getFlights(from: "Минск", to: city)
        tableView.reloadData()
    }
}

extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "✈️ \(flights[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "Бронирование", message: "Забронировать билет?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default) { _ in
            let success = UIAlertController(title: "✅ Успешно!", message: "Билет забронирован", preferredStyle: .alert)
            success.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(success, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
}
