//
//  AgeRangeTableViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

protocol AgeGroupDelegate: AnyObject {
    func didSelectAgeGroup(_ ageGroup: AgeGroup?)
}


class AgeGroupTableViewController: UITableViewController {
    
    weak var delegate: AgeGroupDelegate?
    
    var selectedAgeGroup: AgeGroup?
    
    let ageGroups: [AgeGroup] = [.teenager, .twenties, .thirties, .forties, .etc]
       //선택 목록 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AgeGroupCell")
        // 테이블뷰의 셀 등록
        }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//            return 1
//        }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ageGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgeGroupCell", for: indexPath)
        let ageGroup = ageGroups[indexPath.row]
        cell.textLabel?.text = ageGroup.title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAgeGroup = ageGroups[indexPath.row]
        delegate?.didSelectAgeGroup(selectedAgeGroup)
        dismiss(animated: true, completion: nil)
    }

}

