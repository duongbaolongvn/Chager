//
//  ViewController.swift
//  Chager
//
//  Created by Duong Bao Long on 11/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let circleDrag = CircleDrag()
        let frame = CGRect(x: mainView.bounds.width/2 - 140, y: mainView.bounds.height/2 - 140, width: 280, height: 280)
        circleDrag.frame = frame
        mainView.addSubview(circleDrag)
    }


}

