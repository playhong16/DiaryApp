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
//        nickNameLabel.text =
    }
    
    // 좋아요 버튼 액션
//    @IBAction func isLiked(_ sender: Any) {
//        print("메서드")
//        isLiked.addTarget(self, action: #selector(onClick), for: .touchUpInside)
//    }
    
    @objc func onClick(){
        print("onclick")
        guard let numOfPage = numOfPage else {return print("3434")}
        let diary = dataManager.getDiary()[numOfPage]
        
        print(diary)
        print("111")
        if diary.isLiked == false {
            print("222")
            isLiked.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            diary.isLiked = true
            let data = Diary(id: diary.id, title: diary.title, date: diary.date, emotion: diary.emotion, content: diary.content, hashTag: diary.hashTag, image: diary.image, isLiked: true)
            dataManager.updateDiary(data: data)
            
            print(data)
        }else{
            print("333")
//            diary.isLiked = false
            isLiked.setImage(UIImage(systemName: "heart"), for: .normal)
            let data = Diary(id: diary.id, title: diary.title, date: diary.date, emotion: diary.emotion, content: diary.content, hashTag: diary.hashTag, image: diary.image, isLiked: false)
            dataManager.updateDiary(data: data)
            
            print(data)
        }
        
    }

    
    
    // 텍스트뷰 설정
    func textViewSetUp(){
        // 수정 안되게
        contentTextView.isEditable = false
    }
    
    
    // 뒤로가기
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
