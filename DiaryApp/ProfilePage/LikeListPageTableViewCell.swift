//
//  LikeListPageTableViewCell.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/20.
//

import UIKit

class LikeListPageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var emotionLabel: UILabel!
    
    @IBOutlet weak var diaryLabel: UILabel!
    
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = UIColor.customBeige.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: Diary) {
        titleLabel.text = data.title
        dateLabel.text = DateFormatter.formatTime(date: data.date)
        diaryLabel.text = data.content
        emotionLabel.text = data.emotion.title
        emotionLabel.clipsToBounds = true
        
        titleLabel.font = DiaryFont.titleFont
        dateLabel.font = DiaryFont.timeFont
        diaryLabel.font = DiaryFont.contentFont
    }
}
