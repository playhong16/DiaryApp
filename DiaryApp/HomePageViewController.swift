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

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingActionButton: UIButton!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getFontName()
    }
    
    // MARK: - Configure

    private func configureUI() {
        configureTableView()
        configureFloatingActionButton()
        configureCategoryButton()
    }
    
    private func configureTableView() {
        view.backgroundColor = .creamYellow
//        titleLabel.font = UIFont(name: "NanumSquareRoundB", size: 26)
        titleLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 30)
        dateLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 16)
        dateLabel.textColor = .customYellow
        titleLabel.textColor = .black
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    func configureCategoryButton() {
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
    
    func getFontName() {
            for family in UIFont.familyNames {

                let sName: String = family as String
                print("family: \(sName)")
                        
                for name in UIFont.fontNames(forFamilyName: sName) {
                    print("name: \(name as String)")
                }
            }
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
        let diraryList = dataManager.getDiary()
        cell.selectionStyle = .none
        cell.titleLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 22)
        cell.nicknameLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 18)
        cell.timeLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 18)
//        cell.titleLabel.font = UIFont(name: "NanumSquareRoundL", size: 16)
//        cell.timeLabel.font = UIFont(name: "NanumSquareRoundL", size: 12)
//        cell.nicknameLabel.font = UIFont(name: "NanumSquareRoundL", size: 12)
        cell.titleLabel.text = diraryList[indexPath.row].title
        cell.moodLabel.text = diraryList[indexPath.row].emotion
        cell.configureCell()
        return cell
    }
    
    
    
    
}
