//
//  AddPageViewController.swift
//  DiaryApp
//
//  Created by DJ S on 2023/08/16.
//

import UIKit

class AddPageViewController: UIViewController {
    
    // 아웃렛 변수들 선언
    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var memoTitle: UITextField!
    @IBOutlet weak var memoContent: UITextView!
        
    // 선택된 감정을 저장할 변수
    var selectedEmotion: Emotion?
    
    private var emotionMenu: UIMenu {
        let menu = UIMenu(title: "연령대별", children: createEmotionMenu())
        return menu
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기화 설정을 위한 함수 호출
        setUp()
        
        // 텍스트 필드의 델리게이트 설정
        self.title = "일기 작성하기"
        memoTitle.delegate = self
        
        // 키보드 관련 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Setting
    
    func setUp (){
        view.backgroundColor = .customBeige
        navigationItem.rightBarButtonItem?.tintColor = .customBrown
        
        // memoTitle 디자인 설정
        memoTitle.layer.borderColor = UIColor.black.cgColor
        memoTitle.layer.borderWidth = 1.0
        memoTitle.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: memoTitle.frame.height))
        memoTitle.leftView = paddingView
        memoTitle.leftViewMode = .always
        memoTitle.borderStyle = .none
        
        // memoContent 디자인 설정
        memoContent.layer.borderColor = UIColor.black.cgColor
        memoContent.layer.borderWidth = 1.0
        memoContent.layer.cornerRadius = 8
        memoContent.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // emotionButton 디자인 설정
        emotionButton.menu = emotionMenu
        emotionButton.layer.borderColor = UIColor.black.cgColor
        emotionButton.layer.borderWidth = 1.0
        emotionButton.layer.cornerRadius = 8
    }
    
    private func createEmotionMenu() -> [UIAction] {
        let emotionAction = Emotion.allCases.map { emotion in
            UIAction(title: emotion.title) { action in
                self.selectedEmotion = emotion
                self.emotionButton.setTitle(emotion.title, for: .normal)
            }
        }
        return emotionAction
    }
    
    // MARK: - Keyboard
    
    // 키보드 나타날 때 호출되는 함수
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                memoContent.contentInset = contentInsets
                memoContent.scrollIndicatorInsets = contentInsets
        }
    }
    
    // 키보드 사라질 때 호출되는 함수
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
            memoContent.contentInset = contentInsets
            memoContent.scrollIndicatorInsets = contentInsets
    }
    
    // 화면의 다른 곳을 터치했을 때 키보드 내리는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 터치 시 키보드 내리기
    }
    
    // MARK: - Interface Builder Action
    
    // 작성하기 버튼이 눌렸을 때 처리하는 함수
    @IBAction func saveButton(_ sender: Any) {
        // 감정, 제목, 내용을 저장
        guard let title = memoTitle.text,
              let content = memoContent.text,
              !title.isEmpty, !content.isEmpty else {
            // 필요한 정보가 입력되지 않았을 경우 처리
            return
        }
        
        let currentDate = Date()
        let newDiary = Diary(title: title, date: currentDate, emotion: selectedEmotion ?? .happy, content: content, isLiked: false)
        
        // 데이터 관리자를 통해 일기 저장
        DataManager.shared.saveDiary(data: newDiary)
        performSegue(withIdentifier: "saveFromAddPage", sender: nil)
    }
}

// MARK: - Extension

extension AddPageViewController: UITextFieldDelegate {
    
    // 텍스트 필드에서 Return 키를 눌렀을 때 호출되는 함수
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 내리기
        return true
    }
}
