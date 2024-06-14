//
//  ViewController.swift
//  iCrypto
//
//  Created by Luan Cabral on 06/01/24.
//

import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Crypto Go"
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        setupView()
        viewModel.fetchCoins()
    }
    
    private func showPopUpError(_ alertData: AlertModel) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        alert.title = alertData.title
        alert.message = alertData.message
        self.present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell,
              let coin = viewModel.coins[safe: indexPath.row] else { return .init() }
        cell.setupCell(with: coin)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let coin = viewModel.coins[safe: indexPath.row] else { return }
        let viewModel = CryptoDetailsViewModel(coin)
        let viewController = CryptoDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: ViewCode {
    func buildHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    func showError(_ alertData: AlertModel) {
        self.showPopUpError(alertData)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension HomeViewController: CoinTableViewCellDelegate {
    func favoriteAction() {
        self.tableView.reloadData()
    }
}
