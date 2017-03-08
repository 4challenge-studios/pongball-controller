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
    var cor: String = "black"
    
    @IBOutlet weak var kickImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var kickOutlet: UIButton!
    @IBOutlet weak var rightOutlet: UIButton!
    @IBOutlet weak var leftOutlet: UIButton!
    func conectado(nome: String) {
        
        DispatchQueue.main.async {
            self.conectado.text = nome
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate.multipeer?.delegate = self
    }
    
    func mudarCor(cor: String) {
        DispatchQueue.main.async {
            self.imageView.image = UIImage.init(named: "control_\(cor)")
            self.kickImageView.image = UIImage.init(named: "kick_\(cor)_up")
            self.rightImageView.image = UIImage.init(named: "right_\(cor)_up")
            self.leftImageView.image = UIImage.init(named: "left_\(cor)_up")
            self.cor = cor
        }
    }

    @IBAction func chute(_ sender: UIButton) {
        kickImageView.image = UIImage.init(named: "kick_\(cor)_up")
    }
    
    
    @IBAction func chuteDown(_ sender: UIButton) {
        enviaMensagem(comando: "kick")
        kickImageView.image = UIImage.init(named: "kick_\(cor)_down")
    }
    
    
    @IBAction func direita(_ sender: UIButton) {
        enviaMensagem(comando: "rightUp")
        rightImageView.image = UIImage.init(named: "right_\(cor)_up")
    }
    
    @IBAction func direitaTouchDown(_ sender: UIButton) {
        enviaMensagem(comando: "rightDown")
        rightImageView.image = UIImage.init(named: "right_\(cor)_down")
        
    }
    
    @IBAction func esquerda(_ sender: UIButton) {
        enviaMensagem(comando: "leftUp")
        leftImageView.image = UIImage.init(named: "left_\(cor)_up")
    }
    
    @IBAction func leftTouchDown(_ sender: Any) {
        enviaMensagem(comando: "leftDown")
        
        leftImageView.image = UIImage.init(named: "left_\(cor)_down")
        
    }
    
    @IBAction func playpause(_ sender: UIButton) {
        
        if self.playPause {
            enviaMensagem(comando: "play")
            print("play")
        }
        else {
            enviaMensagem(comando: "pause")
            print("pause")
        }

        self.playPause = !self.playPause
    }
    
    func enviaMensagem(comando: String) {
        let sessao = appDelegate.multipeer!.session
        
        guard let master = self.appDelegate.multipeer?.displayNameMaster else {
            return
        }
        
        DispatchQueue.main.async {
            do {
                try sessao.send(comando.data(using: .utf8, allowLossyConversion: false)!, toPeers: [master], with: .reliable)
            }catch _ {
                
            }
        }
    }
    
}


