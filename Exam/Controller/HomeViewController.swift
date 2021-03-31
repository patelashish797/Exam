//
//  ViewController.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import UIKit

class HomeViewController: UIViewController, AlertDisplayer {
    
    private var viewModel: SchoolInfoViewModel!

    lazy var tableview: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SchoolInfoViewModel(delegate: self)
        viewModel.fetchSchoolInfo()
        self.navigationItem.title = "School Info"

        view.addSubview(tableview)
        self.tableview.tableFooterView = createSpinnerFooter()
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }

    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schoolNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel.schoolNames[indexPath.row].schoolName
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schoolID = viewModel.schoolNames[indexPath.row].schoolID
        let scoreInfoString = viewModel.getScoreInfoFor(id: schoolID)

        let detailViewController = DetailViewController()
        detailViewController.scoreInfoString = scoreInfoString
        self.navigationController?.pushViewController(detailViewController, animated: true)

    }
        
}

extension HomeViewController: SchoolInfoViewModelDelegate {
    func onFetchFailed(with reason: String) {
        let title = "Error"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title, message: reason, actions: [action])
    }
    
    func onFetchSchoolInfoCompleted() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.tableview.tableFooterView = nil
        }
    }
}
