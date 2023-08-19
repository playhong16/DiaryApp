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
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var isLiked: UIButton!
    
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
        
        isLiked.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    // 전달받은 데이터 보여주기
    func showDiary(){
        guard let numOfPage = numOfPage else {return}
        
        let diary = dataManager.getDiary()[numOfPage]
        print("sender -> \(diary)")
        
        // Date to String
        let formatter = DateFormatter()
        formatter.dateFormat = "MM / dd / yyyy"
        let dateStr = formatter.string(from: diary.date)
        
        titleLabel.text = diary.title
        moodLabel.text = diary.emotion.title
        dateLabel.text = dateStr
        contentTextView.text = diary.content
        // nickname 가져와야함
        nickNameLabel.text = "개굴개굴개구리" // 임시
        
        // font 설정
        configureLabelFont()
        print("1 - \(diary.isLiked)")
    }
    
    // 좋아요 클릭 이벤트
    @objc func onClick(){
        guard let numOfPage = numOfPage else {return}
        var diary = dataManager.getDiary()[numOfPage]
        
        if diary.isLiked == false {
            isLiked.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            diary.isLiked = true
            let data = Diary(id: diary.id, title: diary.title, date: diary.date, emotion: diary.emotion, content: diary.content, hashTag: diary.hashTag, image: diary.image, isLiked: true)
            dataManager.updateDiary(data: data)
            print("2 - \(diary.isLiked)")
        }else{
            isLiked.setImage(UIImage(systemName: "heart"), for: .normal)
            diary.isLiked = false
            let data = Diary(id: diary.id, title: diary.title, date: diary.date, emotion: diary.emotion, content: diary.content, hashTag: diary.hashTag, image: diary.image, isLiked: false)
            dataManager.updateDiary(data: data)
            print("3 - \(diary.isLiked)")
        }
        print("4 - \(diary.isLiked)")
    }

    // 텍스트뷰 설정
    func textViewSetUp(){
        // 수정 안되게
        contentTextView.isEditable = false
    }
    
    // 뒤로가기 (삭제예정)
//    @IBAction func backBtn(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
    // 폰트 설정
    private func configureLabelFont() {
        titleLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 26)
        nickNameLabel.font = UIFont(name: "NanumSquareRoundL", size: 17)
        dateLabel.font = UIFont(name: "NanumSquareRoundL", size: 17)
        contentTextView.font = UIFont(name: "NanumSquareRoundL", size: 25)
    }
}
