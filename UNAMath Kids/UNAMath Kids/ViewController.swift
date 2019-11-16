//
//  ViewController.swift
//  UNAMath Kids
//
//  Created by MacOS Mojave on 11/15/19.
//  Copyright © 2019 JAGS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Título encabezado
        self.title = "UNAMath Kids"
        self.view.backgroundColor = UIColor.white
        
        //Se ejecuta la funcion configurarVista()
        configurarVista()
    }
    
    //Función botón que ejecuta la funcion Preguntas() para comenzar la partida
    @objc func buttonComenzar() {
        let preguntas = Preguntas()
        self.navigationController?.pushViewController(preguntas, animated: true)
    }
    
    //Se configuran los constraints del label y del botón
    func configurarVista() {
        self.view.addSubview(labelTitulo)
        labelTitulo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        labelTitulo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelTitulo.widthAnchor.constraint(equalToConstant: 350).isActive = true
        labelTitulo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.view.addSubview(buttonEmpezar)
        buttonEmpezar.heightAnchor.constraint(equalToConstant: 75).isActive = true
        buttonEmpezar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonEmpezar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonEmpezar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
    }
    
    //Atributos del label
    let labelTitulo: UILabel = {
        let labelTitulo = UILabel()
        labelTitulo.text = "UNAMath Kids"
        labelTitulo.textColor = UIColor.darkGray
        labelTitulo.textAlignment = .center
        labelTitulo.font = UIFont.systemFont(ofSize: 46)
        labelTitulo.numberOfLines = 2
        labelTitulo.translatesAutoresizingMaskIntoConstraints = false
        return labelTitulo
    }()
    
    //Atributos del boton
    let buttonEmpezar: UIButton = {
        let buttonEmpezar = UIButton()
        buttonEmpezar.setTitle("Empezar", for: .normal)
        buttonEmpezar.setTitleColor(UIColor.white, for: .normal)
        buttonEmpezar.titleLabel?.font = .systemFont(ofSize: 24)
        buttonEmpezar.backgroundColor = UIColor.purple
        buttonEmpezar.layer.cornerRadius = 20
        buttonEmpezar.layer.masksToBounds = true
        buttonEmpezar.translatesAutoresizingMaskIntoConstraints = false
        buttonEmpezar.addTarget(self, action: #selector(buttonComenzar), for: .touchUpInside)
        return buttonEmpezar
    }()
}
