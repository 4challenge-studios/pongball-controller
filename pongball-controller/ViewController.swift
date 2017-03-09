//
//  ViewController.swift
//  PongControle
//
//  Created by Samuel Honorato on 09/02/17.
//  Copyright © 2017 Samuel Honorato. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MultiPeerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var conectado: UILabel!
    
    //Se playPause = true voltar o jogo, playPause = false pausa o jogo
    var playPause: Bool = false
    var color: Colors = .black
    
    @IBOutlet weak var kickImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var kickOutlet: UIButton!
    @IBOutlet weak var rightOutlet: UIButton!
    @IBOutlet weak var leftOutlet: UIButton!
    
    func connected(name: String) {
        DispatchQueue.main.async {
            self.conectado.text = name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate.multipeer?.delegate = self
    }
    
    func changeColor(color: Colors) {
        DispatchQueue.main.async {
            self.imageView.image = UIImage.init(named: "control_\(color.rawValue)")
            self.kickImageView.image = UIImage.init(named: "\(StateButton.kick.rawValue)_up_\(color.rawValue)")
            self.rightImageView.image = UIImage.init(named: "\(StateButton.right_up.rawValue)_\(color.rawValue)")
            self.leftImageView.image = UIImage.init(named: "\(StateButton.left_up.rawValue)_\(color.rawValue)")
            self.color = color
        }
    }

    @IBAction func chute(_ sender: UIButton) {
        let imageName = "\(StateButton.kick.rawValue)_up_\(color.rawValue)"
        kickImageView.image = UIImage.init(named: imageName)
    }
    
    @IBAction func chuteDown(_ sender: UIButton) {
        let imageName = "\(StateButton.kick.rawValue)_down_\(color.rawValue)"
        sendMessegeServer(message: .kick)
        kickImageView.image = UIImage.init(named: imageName)
    }
    @IBAction func chuteExit(_ sender: UIButton) {
        let imageName = "\(StateButton.kick.rawValue)_up_\(color.rawValue)"
        kickImageView.image = UIImage.init(named: imageName)
    }
    
    
    @IBAction func direita(_ sender: UIButton) {
        let imageName = "\(StateButton.right_up.rawValue)_\(color.rawValue)"
        sendMessegeServer(message: .right_up)
        rightImageView.image = UIImage.init(named: imageName)
    }
    @IBAction func direitaTouchDown(_ sender: UIButton) {
        let imageName = "\(StateButton.right_down.rawValue)_\(color.rawValue)"
        sendMessegeServer(message: .right_down)
        rightImageView.image = UIImage.init(named: imageName)
    }
    @IBAction func direitaExit(_ sender: UIButton) {
        let imageName = "\(StateButton.right_up.rawValue)_\(color.rawValue)"
        sendMessegeServer(message: .right_up)
        rightImageView.image = UIImage.init(named: imageName)
    }
    
    
    @IBAction func esquerda(_ sender: UIButton) {
        let imageName = "\(StateButton.left_up.rawValue)_\(color.rawValue)"
        sendMessegeServer(message: .left_up)
        leftImageView.image = UIImage.init(named: imageName)
    }
    @IBAction func leftTouchDown(_ sender: Any) {
        let imageName = "\(StateButton.left_down.rawValue)_\(color.rawValue)"
        sendMessegeServer(message: .left_down)
        leftImageView.image = UIImage.init(named: imageName)
    }
    @IBAction func esquerdaExit(_ sender: UIButton) {
        let imageName = "\(StateButton.left_up.rawValue)_\(color.rawValue)"
        sendMessegeServer(message: .left_up)
        leftImageView.image = UIImage.init(named: imageName)
    }
    
    
    func informationAlert(title: String, messege: String) {
        let buttonName = "Ok"
        let alert = UIAlertController.init(title: title, message: messege, preferredStyle: .alert)
        let buttonOk = UIAlertAction.init(title: buttonName, style: .default, handler: {
            action in
            let imageName = "\(StateButton.kick.rawValue)_up_\(self.color.rawValue)"
            self.kickImageView.image = UIImage.init(named: imageName)
        })
        
        alert.addAction(buttonOk)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sendMessegeServer(message: StateButton) {
        let sessao = appDelegate.multipeer!.session
        
        
        if let master = self.appDelegate.multipeer?.displayNameMaster {
            DispatchQueue.main.async {
                do {
                    
                    try sessao.send(message.rawValue.data(using: .utf8, allowLossyConversion: false)!, toPeers: [master], with: .reliable)
                }catch _ {
                    
                }
            }
        }
        
        else {
            switch message {
                case .kick, .left_up, .right_up:
                    let title = "Pong Bash not found"
                    let message = "Download and run Pong Bash on the Apple TV for free!"
                    informationAlert(title: title, messege: message)
                default:
                    print("Invalid")
                }
        }
        
    }
}
