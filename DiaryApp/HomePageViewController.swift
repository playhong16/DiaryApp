//
//  HomePageViewController.swift
//  DiaryApp
//
//  Created by playhong on 2023/08/16.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    // MARK: - Properties

    private let dataManager = DataManager.shared
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingActionButton: UIButton!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure

    private func configureUI() {
        configureTableView()
        configureFloatingActionButton()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    private func configureFloatingActionButton() {
        floatingActionButton.backgroundColor = .customYellow
        floatingActionButton.layer.cornerRadius = 0.5 * floatingActionButton.bounds.size.width
        floatingActionButton.layer.borderWidth = 1
        floatingActionButton.layer.borderColor = UIColor.white.cgColor
    }
}

// MARK: - Extension

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataManager.getDiary().count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageCell.identifier, for: indexPath) as? HomePageCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
