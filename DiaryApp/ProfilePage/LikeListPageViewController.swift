//
//  LikeListPageViewController.swift
//  DiaryApp
//
//  Created by Lee on 2023/08/20.
//

import UIKit

class LikeListPageViewController: UIViewController{

    @IBOutlet weak var likeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customBeige
        navigationItem.backBarButtonItem?.tintColor = UIColor.customBrown
        navigationItem.backBarButtonItem?.tintColor = .customBrown
        likeTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LikeListPageViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.getLikedDiary().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeTableView.dequeueReusableCell(withIdentifier: "LikeListCell", for: indexPath) as! LikeListPageTableViewCell
        let diaryList = DataManager.shared.getLikedDiary()
        let diary = diaryList[indexPath.row]
        cell.configure(data: diary)
        return cell
    }
}
