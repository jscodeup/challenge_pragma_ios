//
//  CatBreedsViewController.swift
//  challenge_pragma_ios
//
//  Created by Mac on 6/04/25.
//

import UIKit

final class CatBreedsViewController: UIViewController {

    private let viewModel: CatBreedsViewModel

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Init

    init(viewModel: CatBreedsViewModel) {
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
        bindViewModel()
        activityIndicator.startAnimating()
        viewModel.fetchBreeds()
    }

    // MARK: - UI Setup

    private func setupUI() {
        title = "Catbreeds"
        view.backgroundColor = .systemBackground

        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CatBreedTableViewCell.self,
            forCellReuseIdentifier: CatBreedTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear

        // Search
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Raza en Ingles"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // Activity Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true

        // Add subviews
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Bind ViewModel

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }

        viewModel.onError = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            print("Error fetching breeds: \(error.localizedDescription)")
        }
    }
}

// MARK: - UITableViewDataSource & Delegate

extension CatBreedsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfBreeds()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breed = viewModel.breed(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CatBreedTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CatBreedTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: breed)
        return cell
    }
}

// MARK: - UISearchResultsUpdating

extension CatBreedsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterBreeds(query: searchController.searchBar.text ?? "")
    }
}
