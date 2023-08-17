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
        
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = .init(gray: 1, alpha: 1)
    }
    
    func configure(data: Diary) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        timeLabel.text = "\(data.date)"
        moodLabel.text = data.emotion.title
        
        moodLabel.backgroundColor = data.emotion.color
        moodLabel.layer.cornerRadius = 10
        moodLabel.clipsToBounds = true
    }
}
