//
//  EditprofileViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/16.
//

import UIKit


class EditProfileViewController: UIViewController, AgeGroupDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    
    @IBOutlet weak var editCompleteButton: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var selectAgeGroupButton: UIButton!
    
    // 사용자의 프로필 정보 저장
    var userProfile = ProfileManager.shared.getProfile()
    
    // 연련대 기본 선택 (20대)
    var selectedAgeGroup: AgeGroup = AgeGroup.twenties
    
    var profileimageView = UIImageView(image: UIImage(named: "normalProfile.jpg"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .customBeige
        setSelectedAgeGroup()
        setProfileImageView()
        nTFSet()
        sAGBSet()
        profileIVSet()
        
        navigationController?.navigationBar.tintColor = UIColor.customBrown

        //키보드 설정
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //이미지 탭 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    func setProfileImageView(){
        guard let userProfile = self.userProfile else { return }
        profileImageView.image = userProfile.image      }
    
    func setSelectedAgeGroup() {
        guard let userProfile = self.userProfile else { return }
        selectedAgeGroup = userProfile.age
    }
    
    private func profileIVSet() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.widthAnchor.constraint(equalToConstant: 200.0).isActive =  true
        profileImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.customDarkBeige.cgColor
        profileImageView.layer.cornerRadius = 8
    }
    
    private func nTFSet() {
        guard let userProfile = self.userProfile else {
            return
        }
        nicknameTextField.text = userProfile.nickName
        nicknameTextField.placeholder = "닉네임"
        nicknameTextField.delegate = self
        nicknameTextField.backgroundColor = UIColor.customBeige
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.borderColor = UIColor.customDarkBeige.cgColor
        nicknameTextField.layer.cornerRadius = 8
    }
    private func sAGBSet() {
        //선택된 연령대로 버튼의 타이틀 설정
        selectAgeGroupButton.setTitle("\(selectedAgeGroup.title)", for: .normal)
        
        // 연령대 버튼 좌측 정렬 설정
        selectAgeGroupButton.contentHorizontalAlignment = .left
        
        // 연령대 버튼 테두리 설정
        selectAgeGroupButton.layer.borderWidth = 1
        selectAgeGroupButton.layer.borderColor = UIColor.customDarkBeige.cgColor
        selectAgeGroupButton.layer.cornerRadius = 8
    }
    // 화면이 사라질 때 키보드 관련 알림 제거
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // 키보드가 나타날때 화면 올리는 메서드
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.size.height - view.safeAreaInsets.bottom
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight
            }
        }
    }
    // 키보드가 사라질때 화면 내리는 메서드
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    // 텍스트 필드의 퍈집이 끝났을 때 닉네임 업데이트
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard var userProfile = self.userProfile else { return }
        userProfile.nickName = textField.text ?? ""
    }
    
    // 리턴 키를 눌렀을때 키보드 감추기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 연령대 버튼 눌렀을 때 호출되는 메서드
    @IBAction func selectAgeGroupButtonTapped(_ sender: UIButton) {
        showAgeGroupOptions()
    }
    
    // 연령대 표시 메서드
    func showAgeGroupOptions() {
        let ageGroupVC = AgeGroupTableViewController()
        ageGroupVC.delegate = self
        ageGroupVC.selectedAgeGroup = selectedAgeGroup
        let navController = UINavigationController(rootViewController: ageGroupVC)
        present(navController, animated: true, completion: nil)
    }
    
    // 연령대를 선택하였을때 메서드
    func didSelectAgeGroup(_ ageGroup: AgeGroup?) {
        if let selectedAgeGroup = ageGroup {
           
            // 선택된 연령대로 버튼의 타이틀 변경
            self.selectedAgeGroup = selectedAgeGroup
            selectAgeGroupButton.setTitle("\(selectedAgeGroup.title)", for: .normal)
          
            // 선택된 연령대 저장
            guard let userProfile = self.userProfile else { return }
            let updatedProfile = Profile(nickName: userProfile.nickName, image: userProfile.image, age: selectedAgeGroup, job: userProfile.job)
            ProfileManager.shared.updateProfile(data: updatedProfile)
        }
    }
    
    // 프로필 이미지를 탭했을때의 메서드
    @objc func profileImageTapped() {
        showImagePickerAlert()
    }
    
    //이미지 선택 옵션을 알려주는 알림창 메서드
    func showImagePickerAlert() {
        let alertController = UIAlertController(title: "프로필 사진 변경", message: "사진을 선택하세요", preferredStyle: .actionSheet)
        
        //앨범 선택
        let albumAction = UIAlertAction(title: "내 앨범", style: .default) { _ in
            self.showImagePicker(sourceType: .photoLibrary)
        }
        
        //카메라 선택
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            self.showImagePicker(sourceType: .camera)
        }
        
        //취소 선택
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(albumAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //이미지 피커를 표시하여 프로필 사진을 선택받는 메서드
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    //프로필 사진 변경을 위해 앨범을 열어주는 메서드
    func changeProfilePicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 이미지 선택이 완료되면 선택한 이미지를 프로필 이미지로 저장.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    //수정 완료 버튼
    @IBAction func editCompleteButton(_ sender: UIButton) {
        // 초기화를 원하는 값으로 데이터를 초기화합니다.

        guard let newNickname = nicknameTextField.text,
              let newImage = profileImageView.image else {return}

        // 데이터가 수정되었다면 새로운 값을 저장합니다.


        // 프로필 정보를 업데이트하고 저장
        let updatedProfile = Profile(nickName: newNickname, image: newImage,  age: selectedAgeGroup, job: .student)
        ProfileManager.shared.updateProfile(data: updatedProfile)

        // 화면 전환
        if let profileVC = UIStoryboard(name: "ProfilePage", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            navigationController?.pushViewController(profileVC, animated: true)
        }
 }
}



