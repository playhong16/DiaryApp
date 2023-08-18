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
    
    //선택 목록 배열
    let ageGroups: [AgeGroup] = [.teenager, .twenties, .thirties, .forties, .etc]
    
    // 테이블뷰의 셀 등록
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AgeGroupCell")
        // 테이블뷰의 셀 등록
        }
    
    // 연령대 목록 개수 반환
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ageGroups.count
    }
    
    //셀의 텍스트 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgeGroupCell", for: indexPath)
        let ageGroup = ageGroups[indexPath.row]
        cell.textLabel?.text = ageGroup.title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택된 연령대 가져오기
        let selectedAgeGroup = ageGroups[indexPath.row]
        //연령대 저장
        let defaults = UserDefaults.standard
           defaults.set(selectedAgeGroup.title, forKey: "selectedAgeGroup")
        // 델리게이트를 통해 연령대 전달
        delegate?.didSelectAgeGroup(selectedAgeGroup)
        //선택 창 닫기
        dismiss(animated: true, completion: nil)
    }

}

