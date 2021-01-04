//
//  TableViewController.swift
//  Forecast
//
//  Created by Alexandr on 04.01.2021.
//

import UIKit

class СustomizationViewController: UIViewController {
    
    let sharePromptView = SharePromptView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white

        sharePromptView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(sharePromptView)
        

        
        view.addSubview(sharePromptView)
        sharePromptView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sharePromptView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        sharePromptView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sharePromptView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        
//        temperatureLabel.topAnchor.constraint(equalTo: frameView.topAnchor,constant: 20).isActive = true
//        temperatureLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor,constant: 20).isActive = true
//        temperatureLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor,constant: -20).isActive = true
//        temperatureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        

        
    }
    
}
