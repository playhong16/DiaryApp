//
//  MyPageViewController.swift
//  DiaryApp
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import FSCalendar
import Combine

final class MyPageViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = MyPageViewModel()
    private let dataManager = DataManager.shared
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var subscriptions = Set<AnyCancellable>()
    
    typealias Item = Diary
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureCollectionView()
        configCalender()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.selectDate(date: viewModel.pickedDate)
    }
}

private extension MyPageViewController {
    func configure() {
        view.backgroundColor = .customBeige
        navigationItem.backBarButtonItem?.tintColor = .customDarkBeige
    }
    
    func bind() {
        viewModel.diaryList.receive(on: DispatchQueue.main)
            .sink {
                self.applyItems(items: $0)
            }
            .store(in: &subscriptions)
    }
    
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
        collectionView.backgroundColor = .customBeige
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
            guard let self = self else { return }
            let diary = viewModel.diaryList.value[indexPath.item]
            self.dataManager.removeDiary(id: diary.id)
            viewModel.selectDate(date: viewModel.pickedDate)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let diary = viewModel.diaryList.value[indexPath.item]
        let sb = UIStoryboard(name: "MyDetailPage", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MyDetailViewController.identifier) as?
                MyDetailViewController else { return }
        vc.diaryData = diary
        vc.reloading = { [weak self] in
            guard let self = self else { return }
            self.viewModel.selectDate(date: self.viewModel.pickedDate)
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
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
        calendarView.headerHeight = 50
        calendarView.weekdayHeight = 30
        calendarView.backgroundColor = .customBeige
        
        calendarView.appearance.titleFont = .systemFont(ofSize: 22, weight: .bold)
        calendarView.appearance.weekdayFont = .systemFont(ofSize: 20, weight: .heavy)
        calendarView.appearance.headerTitleFont = .systemFont(ofSize: 15, weight: .regular)
        calendarView.appearance.headerTitleColor = .customBrown
        calendarView.appearance.weekdayTextColor = .customDarkBeige
        viewModel.selectDate(date: Date())
    }

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView.frame.size.height = bounds.height
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.pickedDate = date
        viewModel.selectDate(date: date)
    }
}
