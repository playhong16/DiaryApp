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

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingActionButton: UIButton!
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "TODAY"
        label.font = UIFont(name: "NanumSquareRoundB", size: 28)
        return label
    }()
    
    private var ageGroupMenu: UIMenu {
        let menu = UIMenu(title: "연령대별",children: createAgeGroupMenu())
        return menu
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBeige
        navigationItem.backBarButtonItem?.tintColor = .customBrown
        configureUI()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Configure

    private func configureUI() {
        configureTableView()
        configureFloatingActionButton()
        configureCategoryButton()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureCategoryButton() {
        categoryButton.menu = ageGroupMenu
        categoryButton.titleLabel?.font = UIFont(name: "NanumSquareRoundL", size: 14)
        categoryButton.backgroundColor = .white
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.customDarkBeige.cgColor
        categoryButton.layer.cornerRadius = 8
    }
    
    private func configureFloatingActionButton() {
        floatingActionButton.backgroundColor = .customDarkBeige
        floatingActionButton.layer.cornerRadius = 0.5 * floatingActionButton.bounds.size.width
        floatingActionButton.layer.borderWidth = 1
        floatingActionButton.layer.borderColor = UIColor.customBeige.cgColor
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
    
    // MARK: - unwindSegue

    @IBAction func saveFromAddPage(_ sender: UIStoryboardSegue) {
        let row = dataManager.getDiary().count - 1
        tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
}

// MARK: - Extension

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    // 테이블 뷰 셀 선택 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 항목 출력
        performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
        
    }
    
    // 셀 선택 시 디테일 페이지 이동
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let vc = segue.destination as? DetailPageViewController
            
            if let index = sender as? Int {
                vc?.numOfPage = index
            }
            
        }
    }
   
}
