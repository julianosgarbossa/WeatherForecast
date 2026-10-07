//
//  HomeViewController.swift
//  WeatherForecast
//
//  Created by Juliano Sgarbossa on 06/10/26.
//

import UIKit

class HomeViewController: UIViewController {

    private var screen: HomeScreen?
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        screen = HomeScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        viewModel.fetchForecast()
    }
    
    private func configProtocols() {
        screen?.configCollectionProtocols(delegate: self, dataSource: self)
        screen?.configTableProtocols(delegate: self, dataSource: self)
        viewModel.delegate(delegate: self)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(forecast: viewModel.loadCurrentForecst(index: indexPath.row))
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        cell.setupCell(dailyForecast: viewModel.loadCurrentDailyForecast(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func success() {
        screen?.setupView(forecast: viewModel.loadCurrentForecast)
        screen?.hourlyCollectionView.reloadData()
        screen?.dailyTableView.reloadData()
    }
    
    func failure(error: String) {
        let screen = UIView()
        screen.backgroundColor = .white
        view = screen
        showAlert(title: "Atenção", message: error)
    }
}
