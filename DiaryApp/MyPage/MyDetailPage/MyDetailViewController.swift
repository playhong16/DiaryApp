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
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("deinit - MyDetailVC")
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        guard let diaryData = diaryData,
              let title = titleTextField.text,
              let selecteMood = selecteMood else { return }
        let diary = Diary(id: diaryData.id, title: title, date: diaryData.date, emotion: selecteMood, content: diaryTextView.text, hashTag: diaryData.hashTag, image: diaryData.image, isLiked: diaryData.isLiked)
        dataManager.updateDiary(data: diary)
        dismiss(animated: true) {
            self.reloading?()
        }
    }
    
    func configure() {
        guard let diaryData = diaryData else { return }
        titleTextField.text = diaryData.title
        diaryTextView.text = diaryData.content
        dateLabel.text = "\(diaryData.date)"
        moodBtn.setTitle(diaryData.emotion.title, for: .normal)
        moodBtn.backgroundColor = diaryData.emotion.color
        
        diaryTextView.layer.cornerRadius = 10
        moodBtn.layer.cornerRadius = 10
    }
    
    func configMoodBtn() {
        let happy = UIAction(title: "기쁨") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle("기쁨", for: .normal)
            self.moodBtn.backgroundColor = Emotion.happy.color
            self.selecteMood = .happy
        }
        
        let angry = UIAction(title: "화남") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle("화남", for: .normal)
            self.moodBtn.backgroundColor = Emotion.angry.color
            self.selecteMood = .angry
        }
        
        let nomal = UIAction(title: "보통") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle("보통", for: .normal)
            self.moodBtn.backgroundColor = Emotion.nomal.color
            self.selecteMood = .nomal
        }
        
        let sad = UIAction(title: "슬픔") { [weak self] _ in
            guard let self = self else { return }
            self.moodBtn.setTitle("슬쁨", for: .normal)
            self.moodBtn.backgroundColor = Emotion.sad.color
            self.selecteMood = .sad
        }
        
        let buttonMenu = UIMenu(title: "감정 선택", children: [happy, angry, nomal, sad])
        moodBtn.menu = buttonMenu
        moodBtn.showsMenuAsPrimaryAction = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension MyDetailViewController {
    @objc func didTappedDismissBtn() {
        dismiss(animated: true)
    }
}
