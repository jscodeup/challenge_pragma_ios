import UIKit
import Kingfisher

final class CatBreedDetailViewController: UIViewController {

    private let viewModel: CatBreedDetailViewModel

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    private let breedImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let originLabel = UILabel()
    private let intelligenceLabel = UILabel()
    private let adaptabilityLabel = UILabel()
    private let lifeSpanLabel = UILabel()

    // MARK: - Init

    init(viewModel: CatBreedDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }

    // MARK: - UI Setup

    private func setupUI() {
        title = viewModel.name
        view.backgroundColor = .systemBackground

        // IMAGE FIXED ON TOP
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        breedImageView.contentMode = .scaleAspectFill
        breedImageView.clipsToBounds = true
        view.addSubview(breedImageView)

        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            breedImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breedImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breedImageView.heightAnchor.constraint(equalToConstant: 600)
        ])

        // SCROLLABLE CONTENT BELOW IMAGE
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: breedImageView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        // DESCRIPTION + INFO
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 22)
        contentStackView.addArrangedSubview(descriptionLabel)

        [originLabel, intelligenceLabel, adaptabilityLabel, lifeSpanLabel].forEach {
            $0.font = .systemFont(ofSize: 22)
            $0.numberOfLines = 0
            contentStackView.addArrangedSubview($0)
        }
        
        originLabel.accessibilityIdentifier = "originLabel"
    }

    // MARK: - Data

    private func setupData() {
        if let url = URL(string: viewModel.imageUrl ?? "") {
            breedImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo")) { result in
                switch result {
                case .success(let value):
                    let image = value.image
                    let aspectRatio = image.size.height / image.size.width
                    self.breedImageView.heightAnchor.constraint(equalTo: self.breedImageView.widthAnchor, multiplier: aspectRatio).isActive = true
                case .failure:
                    break
                }
            }
        }

        descriptionLabel.text = viewModel.description
        originLabel.text = "País de Origen: \(viewModel.origin)"
        intelligenceLabel.text = "Inteligencia: \(viewModel.intelligence)"
        adaptabilityLabel.text = "Adaptabilidad: \(viewModel.adaptability)"
        lifeSpanLabel.text = "Esperanza de vida: \(viewModel.lifeSpan)"
    }
}
