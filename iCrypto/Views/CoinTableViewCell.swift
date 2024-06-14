//
//  CoinCellTableViewCell.swift
//  iCrypto
//
//  Created by Luan Cabral on 13/01/24.
//

import UIKit
import SDWebImage

protocol CoinTableViewCellDelegate: AnyObject {
    func favoriteAction()
}

final class CoinTableViewCell: UITableViewCell {
    
    static let identifier = "CoinTableViewCell"
    
    weak var delegate: CoinTableViewCellDelegate?
    
    // MARK: - UI Components
    private lazy var coinLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var coinNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let container = UIView()
    let rectangle = UIView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupCell(with coin: Coin) {
        coinNameLabel.text = coin.name
        setUpButtonImage()
        setupView()
        coinLogo.sd_setImage(with: coin.logoURL)
    }
    
    func setUpButtonImage() {
//        let image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
//        favoriteButton.setImage(image, for: .normal)
    }
    
    @objc
    func favoriteAction() {
        self.delegate?.favoriteAction()
    }
}

// MARK: - ViewCode Protocol
extension CoinTableViewCell: ViewCode {
    func buildHierarchy() {
        self.contentView.addSubview(coinLogo)
        self.contentView.addSubview(coinNameLabel)
        self.contentView.addSubview(favoriteButton)
        self.contentView.addSubview(rectangle)
        self.contentView.addSubview(container)
        container.addSubview(rectangle)
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            coinNameLabel.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
