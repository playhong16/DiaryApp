//
//  DetailPageViewController.swift
//  DiaryApp
//
//  Created by t2023-m0067 on 2023/08/16.
//

import UIKit

//class DataStore {
//    static var dataManager = DataManager.shared
//}

class DetailPageViewController: UIViewController {

    // MARK: - Type Properties

    private let dataManager = DataManager.shared
    
    // MARK: - Interface Builder Outlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var baseLine: UILabel!
    @IBOutlet weak var defaultLabel: UILabel! // 디폴드라벨(감정)
    
    // 선택한 셀 인덱스 값 받아오기
    var numOfPage: Int?
    
    // 해시태그, 좋아요는 아직 안 함
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBeige
        navigationItem.backBarButtonItem?.tintColor = .customBrown
        contentTextView.backgroundColor = .customBeige
        
        showDiary()
        
        textViewSetUp()
        
//        isLiked.layer.borderColor = UIColor.customDarkBeige.cgColor
        heartButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    // MARK: - Setting
    private func setHeartButton(isLiked: Bool) {
        if isLiked {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    // MARK: - Action
    
    // 전달받은 데이터 보여주기
    func showDiary(){
        guard let numOfPage = numOfPage else {return}
        
        let diary = dataManager.getTodayDiaryList()[numOfPage]
        
        // Date to String
        let formatter = DateFormatter()
        formatter.dateFormat = "MM / dd / yyyy"
        let dateStr = formatter.string(from: diary.date)
        
        titleLabel.text = diary.title
        moodLabel.text = diary.emotion.title
        dateLabel.text = dateStr
        contentTextView.text = diary.content
        defaultLabel.text = "나는 지금.."
        // nickname 가져와야함
//        nickNameLabel.text = "개굴개굴개구리" // 임시
        
        // design 설정
        configureLabelFont()
        configureLabelLayout()
        setHeartButton(isLiked: diary.isLiked)
    }
    
    // 좋아요 클릭 이벤트
    @objc func onClick(){
        guard let numOfPage = numOfPage else {return}
        var diary = dataManager.getTodayDiaryList()[numOfPage]
        
        if diary.isLiked == false {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            diary.isLiked = true
            let data = Diary(id: diary.id, title: diary.title, date: diary.date, emotion: diary.emotion, content: diary.content, hashTag: diary.hashTag, image: diary.image, isLiked: true)
            dataManager.updateDiary(data: data)
            dataManager.saveLikedDiary(data: data)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            diary.isLiked = false
            let data = Diary(id: diary.id, title: diary.title, date: diary.date, emotion: diary.emotion, content: diary.content, hashTag: diary.hashTag, image: diary.image, isLiked: false)
            dataManager.updateDiary(data: data)
            dataManager.removeLikedDiary(id: data.id)
        }
    }

    // 텍스트뷰 설정
    func textViewSetUp(){
        // 수정 안되게
        contentTextView.isEditable = false
    }

    // 폰트 설정
    private func configureLabelFont() {
        titleLabel.font = UIFont(name: "NanumSquareRoundL", size: 25)
//        nickNameLabel.font = UIFont(name: "NanumSquareRoundL", size: 17)
        dateLabel.font = UIFont(name: "NanumSquareRoundL", size: 13)
        contentTextView.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 28)
        defaultLabel.font = UIFont(name: "NanumSquareRoundL", size: 13)
    }
    
    private func configureLabelLayout(){
        baseLine.layer.borderWidth = 1
        baseLine.layer.borderColor = UIColor.customDarkBeige.cgColor
//        titleLabel.layer.borderWidth = 1
//        moodLabel.layer.borderWidth = 1
//        dateLabel.layer.borderWidth = 1
////        nickNameLabel.layer.borderWidth = 1
//
//        titleLabel.layer.cornerRadius = 8
//        moodLabel.layer.cornerRadius = 8
//        dateLabel.layer.cornerRadius = 8
////        nickNameLabel.layer.cornerRadius = 8
//
//        titleLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
//        moodLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
//        dateLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
////        nickNameLabel.layer.borderColor = UIColor.customDarkBeige.cgColor
    }
}

