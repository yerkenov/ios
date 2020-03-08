//
//  ViewController4.swift
//  lab3
//
//  Created by Almukhammed Yerkenov on 3/8/20.
//  Copyright © 2020 Almukhammed Yerkenov. All rights reserved.
//

import Foundation
import UIKit

class ViewController4: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginTapped(_ sender: Any) {
        navigateToMainInterface()
    }
    private func navigateToMainInterface() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(identifier: "ViewController4") as? ViewController4 else {
            return
        }
        present(mainNavigationVC, animated: true, completion: nil)
    }
}
