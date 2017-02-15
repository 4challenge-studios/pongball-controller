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
    
    func conectado(nome: String) {
        
        DispatchQueue.main.async {
            self.conectado.text = nome
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate.multipeer?.delegate = self
    }

    @IBAction func chute(_ sender: UIButton) {
        enviaMensagem(comando: "kick")
        print("kick")
        
    }
    
    @IBAction func direita(_ sender: UIButton) {
        enviaMensagem(comando: "rightUp")
        print("rightUp")
    }
    
    @IBAction func direitaTouchDown(_ sender: UIButton) {
        enviaMensagem(comando: "rightDown")
        print("rightDown")
    }
    
    @IBAction func esquerda(_ sender: UIButton) {
        enviaMensagem(comando: "leftUp")
        print("leftUp")
    }
    
    @IBAction func leftTouchDown(_ sender: Any) {
        enviaMensagem(comando: "leftDown")
        print("leftDown")
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
        DispatchQueue.main.async {
            do {
                try sessao.send(comando.data(using: .utf8, allowLossyConversion: false)!, toPeers: sessao.connectedPeers, with: .reliable)
                
            }catch _ {
                
            }
        }
    }
    
}


