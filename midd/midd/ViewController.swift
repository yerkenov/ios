//
//  ViewController.swift
//  midd
//
//  Created by Almukhammed Yerkenov on 3/7/20.
//  Copyright © 2020 Almukhammed Yerkenov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
    }
    
    func addGesture() {
        views.forEach {(view) in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTap))
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func viewDidTap(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ColorVC") as! viewcontrollertwo
            
            vc.onColorSelected = { color in
                
                view.backgroundColor = color
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
}
