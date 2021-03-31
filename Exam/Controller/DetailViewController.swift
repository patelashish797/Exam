//
//  DetailViewController.swift
//  Exam
//
//  Created by Ashish Patel on 3/30/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var scoreInfoString: String?
    
    lazy var detailInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailInfoLabel)
        NSLayoutConstraint.activate([
            detailInfoLabel.topAnchor.constraint(equalTo: view.topAnchor),
            detailInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        if let scoreInfoString = scoreInfoString {
            detailInfoLabel.text = scoreInfoString
        }
    }
    
}
