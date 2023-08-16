//
//  EditprofileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

class EditProfileViewController: UIViewController, AgeGroupDelegate {
    

    @IBOutlet weak var selectAgeGroupButton: UIButton!
    // 연령대 선택 버튼
    
    var selectedAgeGroup: AgeGroup = .twenties
    // 연련대 기본 선택 (20대)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectAgeGroupButton.setTitle("\(selectedAgeGroup.title)", for: .normal)
        // 기본으로 선택된 연령대로 버튼의 타이틀 설정
        selectAgeGroupButton.contentHorizontalAlignment = .left
        // 연령대 버튼 좌측 정렬 설정
        selectAgeGroupButton.layer.borderWidth = 1.0
        selectAgeGroupButton.layer.borderColor = UIColor.gray.cgColor
        selectAgeGroupButton.layer.cornerRadius = 5.0
           // 연령대 버튼 테두리 설정
    }
    
    @IBAction func selectAgeGroupButtonTapped(_ sender: UIButton) {
        showAgeGroupOptions() // 버튼 액션
    }
    
    func showAgeGroupOptions() {
        let ageGroupVC = AgeGroupTableViewController()
        ageGroupVC.delegate = self
        ageGroupVC.selectedAgeGroup = selectedAgeGroup
        let navController = UINavigationController(rootViewController: ageGroupVC)
        present(navController, animated: true, completion: nil)
    } // 선택 화면을 모달로 보여주는 메서드
    
    func didSelectAgeGroup(_ ageGroup: AgeGroup?) {
        if let selectedAgeGroup = ageGroup {
            // 선택된 연령대로 버튼의 타이틀 변경
            selectAgeGroupButton.setTitle("\(selectedAgeGroup.title)", for: .normal)
            //프린트
        }
    }
    
    
    
    

}
