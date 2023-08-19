//
//  MyDetailViewController.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Combine

class MyDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodBtn: UIButton!
    @IBOutlet weak var diaryTextView: UITextView!
    
    static let identifier = "MyDetailViewController"
    let dataManager = DataManager.shared
    var diaryData: Diary?
    var selecteMood: Emotion?
    var reloading: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configMoodBtn()
        setKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
    
    deinit {
        print("deinit - MyDetailVC")
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        guard let diaryData = diaryData,
              let title = titleTextField.text else { return }
        if diaryData.title == title && diaryData.content == diaryTextView.text && diaryData.emotion == selecteMood { return }
        let diary = Diary(id: diaryData.id,
                          title: title,
                          date: diaryData.date,
                          emotion: selecteMood ?? diaryData.emotion,
                          content: diaryTextView.text,
                          hashTag: diaryData.hashTag,
                          image: diaryData.image,
                          isLiked: diaryData.isLiked)
        dataManager.updateDiary(data: diary)
        dismiss(animated: true) {
            self.reloading?()
        }
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        guard titleTextField.isEditing != true else { return }
        if self.view.window?.frame.origin.y == 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y -= keyboardHeight / 3
                }
            }
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            UIView.animate(withDuration: 1) {
                self.view.window?.frame.origin.y = 0
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension MyDetailViewController {
    func configure() {
        guard let diaryData = diaryData else { return }
        selecteMood = diaryData.emotion
        
        let dateStr = "\(DateFormatter.formatDate(date: diaryData.date)), \(DateFormatter.formatTime(date: diaryData.date))"
        
        titleTextField.text = diaryData.title
        dateLabel.text = dateStr
        moodBtn.setTitle(diaryData.emotion.title, for: .normal)
        moodBtn.backgroundColor = diaryData.emotion.color
        diaryTextView.text = diaryData.content
        diaryTextView.backgroundColor = .white
        
        diaryTextView.layer.cornerRadius = 8
        moodBtn.layer.cornerRadius = 8
        
        view.backgroundColor = .customBeige
    }
    
    func configMoodBtn() {
        let happy = UIAction(title: "기쁨 \(Emotion.happy.title)") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle(Emotion.happy.title, for: .normal)
            self.moodBtn.backgroundColor = Emotion.happy.color
            self.selecteMood = .happy
        }
        
        let angry = UIAction(title: "화남 \(Emotion.angry.title)") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle(Emotion.angry.title, for: .normal)
            self.moodBtn.backgroundColor = Emotion.angry.color
            self.selecteMood = .angry
        }
        
        let nomal = UIAction(title: "보통 \(Emotion.nomal.title)") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle(Emotion.nomal.title, for: .normal)
            self.moodBtn.backgroundColor = Emotion.nomal.color
            self.selecteMood = .nomal
        }
        
        let sad = UIAction(title: "슬픔 \(Emotion.sad.title)") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle(Emotion.sad.title, for: .normal)
            self.moodBtn.backgroundColor = Emotion.sad.color
            self.selecteMood = .sad
        }
        
        let buttonMenu = UIMenu(title: "감정 선택", children: [happy, angry, nomal, sad])
        moodBtn.menu = buttonMenu
        moodBtn.showsMenuAsPrimaryAction = true
    }
    
    @objc func didTappedDismissBtn() {
        dismiss(animated: true)
    }
}
