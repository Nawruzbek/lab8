import UIKit

class MedicineDetailViewController: UIViewController {
    
    private let medicine: Medicine
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 60
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "📋 Описание"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let compositionCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let compositionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "🔬 Состав"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let compositionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(medicine: Medicine) {
        self.medicine = medicine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithMedicine()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Информация о лекарстве"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionCard)
        descriptionCard.addSubview(descriptionTitleLabel)
        descriptionCard.addSubview(descriptionLabel)
        contentView.addSubview(compositionCard)
        compositionCard.addSubview(compositionTitleLabel)
        compositionCard.addSubview(compositionLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            imageContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 120),
            imageContainer.heightAnchor.constraint(equalToConstant: 120),
            
            imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionCard.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: descriptionCard.topAnchor, constant: 16),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: descriptionCard.leadingAnchor, constant: 16),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: descriptionCard.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionCard.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionCard.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionCard.bottomAnchor, constant: -16),
            
            compositionCard.topAnchor.constraint(equalTo: descriptionCard.bottomAnchor, constant: 16),
            compositionCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            compositionCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            compositionCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            compositionTitleLabel.topAnchor.constraint(equalTo: compositionCard.topAnchor, constant: 16),
            compositionTitleLabel.leadingAnchor.constraint(equalTo: compositionCard.leadingAnchor, constant: 16),
            compositionTitleLabel.trailingAnchor.constraint(equalTo: compositionCard.trailingAnchor, constant: -16),
            
            compositionLabel.topAnchor.constraint(equalTo: compositionTitleLabel.bottomAnchor, constant: 8),
            compositionLabel.leadingAnchor.constraint(equalTo: compositionCard.leadingAnchor, constant: 16),
            compositionLabel.trailingAnchor.constraint(equalTo: compositionCard.trailingAnchor, constant: -16),
            compositionLabel.bottomAnchor.constraint(equalTo: compositionCard.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureWithMedicine() {
        nameLabel.text = medicine.name
        descriptionLabel.text = medicine.description
        compositionLabel.text = medicine.composition
        
        let iconName: String
        switch medicine.name {
        case "Аспирин": iconName = "pill.fill"
        case "Парацетамол": iconName = "capsule.fill"
        case "Нурофен": iconName = "bandage.fill"
        case "Лоратадин": iconName = "leaf.fill"
        case "Амоксициллин": iconName = "cross.case.fill"
        case "Но-шпа": iconName = "heart.fill"
        case "Мезим": iconName = "stomach.fill"
        case "Аквадетрим": iconName = "sun.max.fill"
        default: iconName = "pill"
        }
        
        imageView.image = UIImage(systemName: iconName)
        
        let color: UIColor
        switch medicine.name {
        case "Аспирин": color = .systemRed
        case "Парацетамол": color = .systemBlue
        case "Нурофен": color = .systemOrange
        case "Лоратадин": color = .systemGreen
        case "Амоксициллин": color = .systemPurple
        case "Но-шпа": color = .systemPink
        case "Мезим": color = .systemYellow
        case "Аквадетрим": color = .systemTeal
        default: color = .systemGray
        }
        
        imageView.tintColor = color
        imageContainer.backgroundColor = color.withAlphaComponent(0.1)
    }
}
