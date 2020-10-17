//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Radhi Mighri on 14/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    @IBOutlet weak var foursquareLbl: UILabel!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // to hide the back button and the topbar
//        navigationController?.navigationBar.isHidden = true
        // or change the type of the segue from "show" to "present modaly"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foursquareLbl.text = "Foursquare"
//
//        let parseObject = PFObject(className: "Fruits")
//        parseObject["name"] = "Banana"
//        parseObject["calory"] = 150
//
//        parseObject.saveInBackground { (done, err) in
//            if err != nil {
//                print("DEBUG: \(err?.localizedDescription)")
//            } else {
//                print("DEBUG: Uploaded successfully")
//            }
//        }

        
//        let query = PFQuery(className: "Fruits")
////            .whereKey("name", equalTo: "Apple")
//            .whereKey("calory", greaterThan: 120)
//            .findObjectsInBackground { (objects, err) in
//            if err != nil {
//                print("DEBUG: \(err?.localizedDescription)")
//            } else {
//                print("DEBUG: Objects : \(objects)")
//            }
//        }
        

    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, err) in
                if err != nil {
                    self.makeAlert(titleInput: "Error", messageInput: err?.localizedDescription ?? "Error!")
                } else { // successfully logged in
                    print("DEBUG: Welcome : \(user!.username!)")
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password !")
        }
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (done, err) in
                if err != nil {
                    self.makeAlert(titleInput: "Error", messageInput: err?.localizedDescription ?? "Error!!")
                }else { //user has benn created
                    print("DEBUG: User has benn created successfully")
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)

                }
            }
            
            
        } else {
          makeAlert(titleInput: "Error", messageInput: "Username / Password !")
        }
}
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
        
    }

}
