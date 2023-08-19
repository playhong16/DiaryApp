//
//  MyPageCell.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class MyPageCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    
    static let identifier = "MyPageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = UIColor.customBeige.cgColor
    }
    
    func configure(data: Diary) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        timeLabel.text = DateFormatter.formatTime(date: data.date)
        moodLabel.text = data.emotion.title
        
//        moodLabel.backgroundColor = data.emotion.color
        moodLabel.clipsToBounds = true
        
        titleLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 26)
        contentLabel.font = UIFont(name: "NanumSquareRoundL", size: 14)
        moodLabel.font = UIFont(name: "NanumSquareRoundL", size: 10)
    }
}
