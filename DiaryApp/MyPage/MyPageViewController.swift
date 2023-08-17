//
//  MyPageViewController.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import FSCalendar
import Combine

class MyPageViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = MyPageViewModel()
    let dataManager = DataManager.shared
    var pickedDate: Date = Date()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    var subscriptions = Set<AnyCancellable>()
    
    typealias Item = Diary
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configCalender()
        configureCollectionView()
        bind()
    }
    
    @IBAction func getData(_ sender: UIButton) {
        let data = Diary(title: "hello", date: pickedDate, emotion: .sad, content: UUID().uuidString)
        dataManager.saveDiary(data: data)
        
        viewModel.selectDate(date: pickedDate)
    }
    
    func bind() {
        viewModel.diaryList.receive(on: DispatchQueue.main)
            .sink {
                self.applyItems(items: $0)
            }
            .store(in: &subscriptions)
    }
}

private extension MyPageViewController {
    func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MyPageCell.identifier,
                    for: indexPath) as? MyPageCell else { return nil }
                cell.configure(data: itemIdentifier)
                return cell
            })
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout()
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
            guard let self = self else { return }
            let diary = viewModel.diaryList.value[indexPath.item]
            self.dataManager.removeDiary(id: diary.id)
            viewModel.selectDate(date: pickedDate)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func applyItems(items: [Diary]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items)
        dataSource?.apply(snapShot)
    }
}

extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.diaryList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension MyPageViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    private func configCalender() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.scope = .week
        calendarView.firstWeekday = 2 // 월요일 부터 시작
        calendarView.scrollDirection = .horizontal
        // 캘린더의 cornerRadius 지정
        calendarView.layer.cornerRadius = 20
        calendarView.headerHeight = 30
        calendarView.weekdayHeight = 30
        
        calendarView.appearance.titleFont = .systemFont(ofSize: 22, weight: .regular)
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 20, weight: .regular)
        calendarView.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .regular)
        
        viewModel.selectDate(date: Date())
        
//        let defaultDate = dateFormatter.string(from: todayDate)
//        OptionDetailViewController.pickDate = defaultDate
    }

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.frame.size.height = bounds.height
    }


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        pickedDate = date
        viewModel.selectDate(date: date)
    }
}
