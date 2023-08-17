//
//  AddPageViewController.swift
//  DiaryApp
//
//  Created by DJ S on 2023/08/17.
//

import UIKit

class AddPageViewController: UIViewController {

    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var memoTitle: UITextField!
    @IBOutlet weak var memoContent: UITextView!
    
    var selectedEmotion: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        
    }
    
    func setUp (){
        memoTitle.layer.borderColor = UIColor.black.cgColor
        memoTitle.layer.borderWidth = 1.0
        memoTitle.layer.cornerRadius = 10.0 // You can adjust the
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: memoTitle.frame.height))
        memoTitle.leftView = paddingView
        memoTitle.leftViewMode = .always
        memoTitle.borderStyle = .none
        

        memoContent.layer.borderColor = UIColor.black.cgColor
        memoContent.layer.borderWidth = 1.0
        memoContent.layer.cornerRadius = 10.0
        memoContent.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        emotionButton.layer.borderColor = UIColor.black.cgColor
        emotionButton.layer.borderWidth = 1.0
        emotionButton.layer.cornerRadius = 10.0
    }


    @IBAction func emotionButton(_ sender: UIButton) {
        
        let emotionMenu = UIMenu(title: "감정 선택", options: .displayInline, children: Emotion.allCases.map { emotion in
            UIAction(title: emotion.title, handler: { [weak self] _ in
                // 감정 선택 처리
                self?.selectedEmotion = emotion.title
                sender.setTitle(emotion.title, for: .normal)
                self?.view.layoutIfNeeded() // UI 업데이트 강제
            })
        })
        
        let buttonMenu = UIMenu(title: "", children: [emotionMenu])
        sender.menu = buttonMenu
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        // 감정, 제목, 내용을 가져옴
        guard let title = memoTitle.text,
              let content = memoContent.text,
              !title.isEmpty, !content.isEmpty else {
            // 필요한 정보가 입력되지 않았을 경우 처리
            return
        }
        
        let currentDate = Date()
        
        // Diary 객체 생성
        let newDiary = Diary(title: title, date: currentDate, emotion: selectedEmotion, content: content)
        
        // 데이터 관리자를 통해 일기 저장
        DataManager.shared.saveDiary(data: newDiary)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    

}
