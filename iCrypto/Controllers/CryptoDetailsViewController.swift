//
//  CryptoViewController.swift
//  iCrypto
//
//  Created by Luan Cabral on 19/01/24.
//

import UIKit
import SDWebImage

final class CryptoDetailsViewController: UIViewController {
    // MARK: - ViewModel
    private let viewModel: CryptoDetailsViewModel
    
    //MARK: - UI Elements
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var coinLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "square.and.arrow.up.fill")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var marketCapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var maxSupplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [rankLabel,
                                                    priceLabel,
                                                    marketCapLabel,
                                                    maxSupplyLabel])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    // MARK: - Initializers
    init(viewModel: CryptoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setUp()
    }
    
    private func setImage() {
        coinLogo.sd_setImage(with: viewModel.coin.logoURL)
    }
    
    func setUp() {
        setupView()
        setupData()
        setImage()
    }
    
    private func setupData() {
        self.rankLabel.text = viewModel.rankLabel
        self.priceLabel.text = viewModel.priceLabel
        self.marketCapLabel.text = viewModel.marketCapLabel
        self.maxSupplyLabel.text = viewModel.maxSupplyLabel
    }
    
    private func setupNavigation() {
        self.navigationItem.title = viewModel.coin.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
    }
}

// MARK: - ViewCode Protocol
extension CryptoDetailsViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(coinLogo)
        contentView.addSubview(vStack)
        
        
    }
    
    func buildConstratins() {
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coinLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coinLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            coinLogo.heightAnchor.constraint(equalToConstant: 200),
            coinLogo.widthAnchor.constraint(equalToConstant: 200),
            
            vStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
