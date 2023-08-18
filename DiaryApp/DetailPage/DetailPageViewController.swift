//
//  DetailPageViewController.swift
//  DiaryApp
//
//  Created by t2023-m0067 on 2023/08/16.
//

import UIKit

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
    }
    
    // 좋아요 버튼 액션
    @IBAction func isLiked(_ sender: Any) {
    }
    
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
    
    
    // 텍스트뷰 설정
    func textViewSetUp(){
        // 수정 안되게
        contentTextView.isEditable = false
    }
    
    
    // 뒤로가기
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 탭바 사라지게 하기
    
    
}
