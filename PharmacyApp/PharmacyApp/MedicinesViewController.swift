import UIKit

class MedicinesViewController: UIViewController {
    
    // MARK: - Properties
    private var medicines: [Medicine] = []
    
    // MARK: - UI Elements
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "🚪 Выйти", style: .plain, target: nil, action: nil)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MedicineCell.self, forCellWithReuseIdentifier: "MedicineCell")
        return cv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🔵 MedicinesViewController загружен")
        setupUI()
        loadData()
        displayUserEmail()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = logoutButton
        logoutButton.target = self
        logoutButton.action = #selector(logoutTapped)
        
        view.addSubview(welcomeLabel)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        medicines = MedicineDataService.shared.loadMedicines()
        print("🔵 Загружено лекарств: \(medicines.count)")
        collectionView.reloadData()
    }
    
    private func displayUserEmail() {
        if let email = UserDefaults.standard.string(forKey: "userEmail") {
            welcomeLabel.text = "Добро пожаловать,\n\(email.components(separatedBy: "@").first ?? "")!"
            welcomeLabel.numberOfLines = 2
        }
    }
    
    // MARK: - Actions
    @objc private func logoutTapped() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension MedicinesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicineCell", for: indexPath) as! MedicineCell
        let medicine = medicines[indexPath.row]
        cell.configure(with: medicine)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let medicine = medicines[indexPath.row]
        let detailVC = MedicineDetailViewController(medicine: medicine)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2
        return CGSize(width: width, height: width * 1.2)
    }
}
