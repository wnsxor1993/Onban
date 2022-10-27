//
//  ViewController.swift
//  onban
//
//  Created by Zeto on 2022/10/27.
//

import UIKit
import Then
import SnapKit
import RxCocoa

class LoginViewController: UIViewController {

    private var githubLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16)
        $0.text = "Github Login"
        $0.textColor = .black
    }
    
    private var githubButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
    }
    
    weak var coordinatorDelegate: LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayouts()
    }
}

private extension LoginViewController {
    
    func configureLayouts() {
        self.view.addSubviews(githubLabel, githubButton)
        
        githubLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.width.equalTo(150)
            make.height.equalTo(70)
        }
        
        githubButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.width.equalTo(150)
            make.height.equalTo(70)
        }
    }
}
