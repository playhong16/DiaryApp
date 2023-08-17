//
//  EditprofileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit

class EditProfileViewController: UIViewController, AgeGroupDelegate, UITextFieldDelegate {
    

 
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nicknameTextField: UITextField!
   
    
    @IBOutlet weak var selectAgeGroupButton: UIButton!
 
    
    var userProfile = Profile(nickName: "", age: .twenties, job: .student)

    
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
        
        
        nicknameTextField.text = userProfile.nickName
         nicknameTextField.placeholder = "닉네임"
         nicknameTextField.delegate = self
        // 키보드 설정
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            //키보드 보일때
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            //키보드 숨겼을때
    }
    
    deinit {
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.size.height - view.safeAreaInsets.bottom
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight
            }
        }
    }       // 키보드 보이기 메서드
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }       // 키보드 숨기기 메서드
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userProfile.nickName = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

