//
//  HomePageViewController.swift
//  DiaryApp
//
//  Created by playhong on 2023/08/16.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    // MARK: - Type Properties

    private let dataManager = DataManager.shared
    
    // MARK: - Interface Builder Outlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingActionButton: UIButton!
    
    // MARK: - Properties
    
    private var ageGroupMenu: UIMenu {
        let menu = UIMenu(title: "연령대별",children: createAgeGroupMenu())
        return menu
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .creamYellow
    }
    
    // MARK: - Configure

    private func configureUI() {
        configureTableView()
        configureFloatingActionButton()
        configureCategoryButton()
        configureLabel()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    func configureCategoryButton() {
        categoryButton.menu = ageGroupMenu
        categoryButton.titleLabel?.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 16)
        categoryButton.backgroundColor = .white
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.customYellow.cgColor
        categoryButton.layer.cornerRadius = 10
    }
    
    private func configureFloatingActionButton() {
        floatingActionButton.backgroundColor = .customYellow
        floatingActionButton.layer.cornerRadius = 0.5 * floatingActionButton.bounds.size.width
        floatingActionButton.layer.borderWidth = 1
        floatingActionButton.layer.borderColor = UIColor.creamYellow.cgColor
    }
    
    private func configureLabel() {
        titleLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 30)
        titleLabel.textColor = .black
        dateLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 16)
        dateLabel.textColor = .customYellow
    }
    
    private func createAgeGroupMenu() -> [UIAction] {
        let allAges = UIAction(title: "전체") { action in
            self.categoryButton.titleLabel?.text = action.title
        }
        let teenager = UIAction(title: AgeGroup.teenager.title) { action in
            self.categoryButton.titleLabel?.text = action.title
        }
        let twenties = UIAction(title: AgeGroup.twenties.title) { action in
            self.categoryButton.titleLabel?.text = action.title
        }
        let thirties = UIAction(title: AgeGroup.thirties.title) { action in
            self.categoryButton.titleLabel?.text = action.title
        }
        let forties = UIAction(title: AgeGroup.forties.title) { action in
            self.categoryButton.titleLabel?.text = action.title
        }
        let menuItems = [allAges, teenager, twenties, thirties, forties]
        return menuItems
    }
}

// MARK: - Extension

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getDiary().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageCell.identifier, for: indexPath) as? HomePageCell else {
            return UITableViewCell()
        }
        let diary = dataManager.getDiary()[indexPath.row]
        cell.setupData(diary)
        return cell
    }
}
