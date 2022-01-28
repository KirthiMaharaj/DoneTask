////
////  CalendarViewController.swift
////  Done
////
////  Created by Kirthi Maharaj on 2021/10/25.
////
//
//import UIKit
//import FSCalendar
//
//class CalendarViewController: UIViewController , UITableViewDataSource {
//
//
//
//
//
//    @IBOutlet weak var calanderTable: UITableView!
//    @IBOutlet weak var calender: FSCalendar!
//    @IBOutlet weak var btnScope: UIBarButtonItem!
//    @IBOutlet weak var calanderHeight: NSLayoutConstraint!
//
//    var todoScheduled: [String : [Tasks]] = [:]
//    var dataProvider: TaskManager!
//   // var delegate: SendDataDelegate?
//    var selectedDate = Date()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    func cal(){
//
//        calanderTable.register(TaskViewCell.self, forCellReuseIdentifier: "TaskViewCell")
//
//        calanderTable.rowHeight = UITableView.automaticDimension
//
//
//
//        calender.select(selectedDate)
//
//        calanderHeight.constant = self.view.bounds.height / 2
//
//
//        calender.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(red: 255/255, green: 126/255, blue: 121/255, alpha: 1.0)
//        calender.calendarWeekdayView.weekdayLabels[0].textColor = calender.calendarWeekdayView.weekdayLabels[0].textColor
//    }
//
//    @IBAction func doneButton(_ sender: UIBarButtonItem) {
//
//    }
//
//
//    @IBAction func changeScopeButtonPressed(_ sender: UIBarButtonItem) {
//        if calender.scope == .month {
//            calender.scope = .week
//            btnScope.title = "Month"
//        } else {
//            calender.scope = .month
//            btnScope.title = "Week"
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
//
//
//}
//extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        selectedDate = date
//        calanderTable.reloadData()
//    }
//
//    /* Week/Month Scope 변경 시 달력 높이 변경 */
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        calanderHeight.constant = bounds.height
//        self.view.layoutIfNeeded()
//    }
//
//    /* 달력 날짜에 이벤트 표시 */
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        if let tasks = todoScheduled[date.toString()], tasks.count > 0 { return 1 }
//        return 0
//    }
//
//    /* 이벤트 색상 */
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
//        if let tasks = todoScheduled[date.toString()] {
//            // 작업 미완료 시 빨간색으로 이벤트 표시
//            if tasks.filter({ $0.isCompleted == false }).count > 0 { return [UIColor.systemRed] }
//            // 작업 완료 시 회색으로 이벤트 표시
//            return [UIColor.systemGray2]
//        }
//        return nil
//    }
//
//    /* 날짜 선택 시 이벤트 색상 */
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
//        if let tasks = todoScheduled[date.toString()] {
//            // 작업 미완료 시 빨간색으로 이벤트 표시
//            if tasks.filter({ $0.isCompleted == false }).count > 0 { return [UIColor.systemRed] }
//            // 작업 완료 시 회색으로 이벤트 표시
//            return [UIColor.systemGray2]
//        }
//        return nil
//    }
//
//}
