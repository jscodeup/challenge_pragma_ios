//
//  CatBreedTableViewCell.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//
import UIKit
import Kingfisher

final class CatBreedTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CatBreedTableViewCell"

    private let nameLabel = UILabel()
    private let originLabel = UILabel()
    private let intelligenceLabel = UILabel()
    private let moreLabel = UILabel()
    private let breedImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with breed: CatBreed) {
        nameLabel.attributedText = formatted(title: "Raza", value: breed.name)
        originLabel.attributedText = formatted(title: "Pais Origen", value: breed.origin)
        intelligenceLabel.attributedText = formatted(title: "Inteligencia", value: "\(breed.intelligence)")
        moreLabel.text = "Mas..."

        if let url = URL(string: breed.imageUrl ?? "") {
            let processor = DownsamplingImageProcessor(size: CGSize(width: 300, height: 200))
            let placeholder = UIImage(systemName: "photo")

            breedImageView.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.1)),
                    .cacheOriginalImage
                ]
            )
        }
    }

    private func setupUI() {
        breedImageView.contentMode = .scaleAspectFill
        breedImageView.clipsToBounds = true
        breedImageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.numberOfLines = 0
        originLabel.numberOfLines = 0
        intelligenceLabel.numberOfLines = 0
        moreLabel.textAlignment = .right
        moreLabel.textColor = .systemBlue
        moreLabel.font = .systemFont(ofSize: 14)

        let topStack = UIStackView(arrangedSubviews: [nameLabel, moreLabel])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing

        let bottomStack = UIStackView(arrangedSubviews: [originLabel, intelligenceLabel])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fillEqually

        let contentStack = UIStackView(arrangedSubviews: [topStack, breedImageView, bottomStack])
        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            breedImageView.heightAnchor.constraint(equalTo: breedImageView.widthAnchor, multiplier: 9.0/16.0)
        ])
    }

    private func formatted(title: String, value: String) -> NSAttributedString {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.secondaryLabel
        ]
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.label
        ]

        let result = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        result.append(NSAttributedString(string: value, attributes: valueAttributes))
        return result
    }
}

