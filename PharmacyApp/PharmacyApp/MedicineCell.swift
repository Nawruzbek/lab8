import UIKit

class MedicineCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with medicine: Medicine) {
        nameLabel.text = medicine.name
        
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
        imageView.tintColor = getColor(for: medicine.name)
    }
    
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "Аспирин": return .systemRed
        case "Парацетамол": return .systemBlue
        case "Нурофен": return .systemOrange
        case "Лоратадин": return .systemGreen
        case "Амоксициллин": return .systemPurple
        case "Но-шпа": return .systemPink
        case "Мезим": return .systemYellow
        case "Аквадетрим": return .systemTeal
        default: return .systemGray
        }
    }
}
