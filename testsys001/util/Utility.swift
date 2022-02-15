//
//  Utility.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

import Foundation
import UIKit

func showAlert(view:UIViewController, msg:String){
    let alert = UIAlertController(title: "System", message: msg,         preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
        //Cancel Action
    }))
    
    
    view.present(alert, animated: true, completion: nil)
}

func addBorder(in view:UIView){
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 1
}
