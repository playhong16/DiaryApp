//
//  HomePageCell.swift
//  DiaryApp
//
//  Created by playhong on 2023/08/16.
//

import UIKit

class HomePageCell: UITableViewCell {
    
    // MARK: - Type Properties

    static let identifier = "HomePageCell"
    
    // MARK: - Inteface Builder Outlet
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    // MARK: - Properties

    @IBAction func isLikedAction(_ sender: Any) {
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
    }
    
    func setupData(_ diary: Diary) {
        titleLabel.text = diary.title
        nicknameLabel.text = ProfileManager.shared.getProfile()?.nickName
        moodLabel.text = diary.emotion.title
        timeLabel.text = DateFormatter.formatTime(date: diary.date)
        configureUI()
        setHeartButton(isLiked: diary.isLiked)
    }
    
    private func setHeartButton(isLiked: Bool) {
        if isLiked {
            let image = UIImage(systemName: "heart.fill")
            heartButton.setImage(image, for: .normal)
            heartButton.tintColor = .customDarkBeige
        } else {
            let image = UIImage(systemName: "heart")
            heartButton.setImage(image, for: .normal)
            heartButton.tintColor = .customBeige
        }
    }
    
    private func configureUI() {
        self.selectionStyle = .none
        configureContentView()
        configureLabelFont()
    }
    
    private func configureContentView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.customDarkBeige.cgColor
    }
    
    private func configureLabelFont() {
        titleLabel.font = DiaryFont.titleFont
        nicknameLabel.font = DiaryFont.nicknameFont
        timeLabel.font = DiaryFont.timeFont
        
        titleLabel.textColor = DiaryFont.fontColor
        nicknameLabel.textColor = DiaryFont.fontColor
        timeLabel.textColor = DiaryFont.fontColor
    }
}
