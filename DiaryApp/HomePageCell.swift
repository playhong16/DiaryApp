//
//  HomePageCell.swift
//  DiaryApp
//
//  Created by playhong on 2023/08/16.
//

import UIKit

class HomePageCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "HomePageCell"
    
    // MARK: - Inteface Builder Outlet
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
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
    
    func configureCell() {
        self.backgroundColor = .creamYellow
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.customYellow.cgColor
    }

}
