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
    
    // MARK: - Properties


    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
    }
    
    func setupData(_ diary: Diary) {
        titleLabel.text = diary.title
        nicknameLabel.text = "개굴개굴개구리" // 임시
        moodLabel.text = diary.emotion
        timeLabel.text = "14시 30분"
        configureUI()
    }
    
    private func configureUI() {
        configureContentView()
        titleLabel.font = UIFont(name: "NanumDdarEGeEomMaGa", size: 26)
        nicknameLabel.font = UIFont(name: "NanumSquareRoundL", size: 14)
        timeLabel.font = UIFont(name: "NanumSquareRoundL", size: 10)
    }
    
    private func configureContentView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.customYellow.cgColor
    }
}
