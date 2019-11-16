//
//  Resultado.swift
//  UNAMath Kids
//
//  Created by MacOS Mojave on 11/15/19.
//  Copyright © 2019 JAGS. All rights reserved.
//

import UIKit

class Resultado: UIViewController {
    
    //Se declaran las variables de puntaje y puntajeTotal
    var puntaje: Int?
    var puntajeTotal: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        configurarVista()
    }
    
    //Función que muestra la calificación y clasificación obtenida
    func mostrarClasificacion() {
        var clasificacion = ""
        var color = UIColor.black
        
        guard let puntaje = puntaje, let puntajeTotal = puntajeTotal else { return }
        
        //Se define la constante promedio la cual hace el promedio
        let promedio = puntaje * 100 / puntajeTotal
        
        //Si el promedio es menor que 10 entonces es deficiente
        if promedio < 10 {
            clasificacion = "Deficiente"
            color = UIColor.red
            
        //Si el promedio es menor que 40 entonces es malo
        }  else if promedio < 40 {
            clasificacion = "Mal"
            color = UIColor.orange
            
        //Si el promedio es menor a 60 entonces es bueno
        } else if promedio < 60 {
            clasificacion = "Bien"
            color = UIColor.blue
        
        //Si el promedio es menor a 80 entonces es excelente
        } else if promedio < 80 {
            clasificacion = "Excelente"
            color = UIColor.cyan
            
        //Si el promedio es menor o igual a 100 entonces es perfecto
        } else if promedio <= 100 {
            clasificacion = "Perfecto"
            color = UIColor.green
        }
        
        //Se le pasa el texto de la calificación obtenida al labelClasificación para ser mostrado
        labelClasificacion.text = "\(clasificacion)"
        labelClasificacion.textColor = color
    }
    
    //Función que permite reiniciar el juego
    @objc func buttonAccionReiniciar() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Se configuran los constraints del titulo, puntaje, clasificacion y el boton de reiniciar
    func configurarVista() {
        self.view.addSubview(labelTitulo)
        labelTitulo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        labelTitulo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelTitulo.widthAnchor.constraint(equalToConstant: 250).isActive = true
        labelTitulo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.view.addSubview(labelPuntaje)
        labelPuntaje.topAnchor.constraint(equalTo: labelTitulo.bottomAnchor, constant: 0).isActive = true
        labelPuntaje.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelPuntaje.widthAnchor.constraint(equalToConstant: 150).isActive = true
        labelPuntaje.heightAnchor.constraint(equalToConstant: 60).isActive = true
        labelPuntaje.text = "\(puntaje!) / \(puntajeTotal!)"
        
        self.view.addSubview(labelClasificacion)
        labelClasificacion.topAnchor.constraint(equalTo: labelPuntaje.bottomAnchor, constant: 40).isActive = true
        labelClasificacion.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelClasificacion.widthAnchor.constraint(equalToConstant: 150).isActive = true
        labelClasificacion.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mostrarClasificacion()
        
        self.view.addSubview(buttonEmpezarNuevo)
        buttonEmpezarNuevo.topAnchor.constraint(equalTo: labelClasificacion.bottomAnchor, constant: 40).isActive = true
        buttonEmpezarNuevo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonEmpezarNuevo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonEmpezarNuevo.heightAnchor.constraint(equalToConstant: 75).isActive = true
        buttonEmpezarNuevo.addTarget(self, action: #selector(buttonAccionReiniciar), for: .touchUpInside)
    }
    
    //Atributos del labelTitulo del resultado
    let labelTitulo: UILabel = {
        let labelTitulo = UILabel()
        labelTitulo.text = "Tu puntaje"
        labelTitulo.textColor = UIColor.darkGray
        labelTitulo.textAlignment = .center
        labelTitulo.font = UIFont.systemFont(ofSize: 46)
        labelTitulo.numberOfLines = 2
        labelTitulo.translatesAutoresizingMaskIntoConstraints = false
        return labelTitulo
    }()
    
    //Atributos del labelPuntaje del resultado
    let labelPuntaje: UILabel = {
        let labelPuntaje = UILabel()
        labelPuntaje.text = "0 / 0"
        labelPuntaje.textColor = UIColor.black
        labelPuntaje.textAlignment = .center
        labelPuntaje.font = UIFont.boldSystemFont(ofSize: 24)
        labelPuntaje.translatesAutoresizingMaskIntoConstraints=false
        return labelPuntaje
    }()
    
    //Atributos del labelClasificacion del resultado
    let labelClasificacion: UILabel = {
        let labelResultado = UILabel()
        labelResultado.text = "Clasificacion"
        labelResultado.textColor = UIColor.black
        labelResultado.textAlignment = .center
        labelResultado.font = UIFont.boldSystemFont(ofSize: 24)
        labelResultado.translatesAutoresizingMaskIntoConstraints=false
        return labelResultado
    }()
    
    //Atributos del botón buttonEmpezarNuevo
    let buttonEmpezarNuevo: UIButton = {
        let buttonEmpezarNuevo = UIButton()
        buttonEmpezarNuevo.setTitle("Reiniciar", for: .normal)
        buttonEmpezarNuevo.setTitleColor(UIColor.white, for: .normal)
        buttonEmpezarNuevo.titleLabel?.font = .systemFont(ofSize: 24)
        buttonEmpezarNuevo.backgroundColor = UIColor.orange
        buttonEmpezarNuevo.layer.cornerRadius = 20
        buttonEmpezarNuevo.clipsToBounds = true
        buttonEmpezarNuevo.translatesAutoresizingMaskIntoConstraints = false
        return buttonEmpezarNuevo
    }()
    
}
