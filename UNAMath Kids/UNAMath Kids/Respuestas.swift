//
//  Respuestas.swift
//  UNAMath Kids
//
//  Created by MacOS Mojave on 11/15/19.
//  Copyright © 2019 JAGS. All rights reserved.
//

import UIKit

protocol CeldasPreguntas: class {
    func eligioRespuesta(indexRespuestas: Int)
}

class Respuestas: UICollectionViewCell {
    
    var buttonRespuestaUno: UIButton!
    var buttonRespuestaDos: UIButton!
    var buttonRespuestaTres: UIButton!
    var buttonRespuestaCuatro: UIButton!
    var buttonArreglo = [UIButton]()
    
    weak var delegate: CeldasPreguntas?
    
    //Se obtiene el texto respuesta para los botones
    var pregunta: Pregunta? {
        
        didSet {
            guard let obtenerPregunta = pregunta else { return }
            labelPregunta.text = obtenerPregunta.preguntas
            buttonRespuestaUno.setTitle(obtenerPregunta.respuestas[0], for: .normal)
            buttonRespuestaDos.setTitle(obtenerPregunta.respuestas[1], for: .normal)
            buttonRespuestaTres.setTitle(obtenerPregunta.respuestas[2], for: .normal)
            buttonRespuestaCuatro.setTitle(obtenerPregunta.respuestas[3], for: .normal)
            
            //Si la respuesta es correcta el color del botón cambia a verde
            if obtenerPregunta.contestadas {
                buttonArreglo[obtenerPregunta.correctas].backgroundColor = UIColor.green
                
                //Si la respuesta es incorrecta el color del botón cambia a rojo
                if obtenerPregunta.incorrectas >= 0 {
                    buttonArreglo[obtenerPregunta.incorrectas].backgroundColor = UIColor.red
                }
            }
        }
    }
    
    //Se inicia la funcion configurarVista y se agregan los botones de respuesta al arreglo de botones
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurarVista()
        buttonArreglo = [buttonRespuestaUno, buttonRespuestaDos, buttonRespuestaTres, buttonRespuestaCuatro]
    }
    
    
    @objc func buttonOpcion(sender: UIButton) {
        guard let obtenerPreguta = pregunta else { return }
        
        if !obtenerPreguta.contestadas {
            delegate?.eligioRespuesta(indexRespuestas: sender.tag)
        }
    }
    
    //Se indica el color de fondo de los botones
    override func prepareForReuse() {
        buttonRespuestaUno.backgroundColor = UIColor.white
        buttonRespuestaDos.backgroundColor = UIColor.white
        buttonRespuestaTres.backgroundColor = UIColor.white
        buttonRespuestaCuatro.backgroundColor = UIColor.white
    }
    
    //Se indican los constraints de los label de pregunta
    func configurarVista() {
        addSubview(labelPregunta)
        labelPregunta.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        labelPregunta.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        labelPregunta.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Se declaran las constantes de largo y ancho del botón
        let buttonAncho: CGFloat = 150
        let buttonLargo: CGFloat = 50
        
        //Se indica el tag del botonRespuestaUno
        buttonRespuestaUno = buttonRespuesta(tag: 0)
        
        addSubview(buttonRespuestaUno)
        
        //Se indican las constraints del botonRespuestaUno
        NSLayoutConstraint.activate([buttonRespuestaUno.topAnchor.constraint(equalTo: labelPregunta.bottomAnchor, constant: 20), buttonRespuestaUno.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), buttonRespuestaUno.widthAnchor.constraint(equalToConstant: buttonAncho), buttonRespuestaUno.heightAnchor.constraint(equalToConstant: buttonLargo)])
        buttonRespuestaUno.addTarget(self, action: #selector(buttonOpcion), for: .touchUpInside)
        
        //Se indica el tag del botonRespuestaDos
        buttonRespuestaDos = buttonRespuesta(tag: 1)
        
        addSubview(buttonRespuestaDos)
        
        //Se indican las constraints del botonRespuestaDos
        NSLayoutConstraint.activate([buttonRespuestaDos.topAnchor.constraint(equalTo: buttonRespuestaUno.topAnchor), buttonRespuestaDos.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), buttonRespuestaDos.widthAnchor.constraint(equalToConstant: buttonAncho), buttonRespuestaDos.heightAnchor.constraint(equalToConstant: buttonLargo)])
        buttonRespuestaDos.addTarget(self, action: #selector(buttonOpcion), for: .touchUpInside)
        
        //Se indica el tag del botonRespuestaTres
        buttonRespuestaTres = buttonRespuesta(tag: 2)
        
        addSubview(buttonRespuestaTres)
        
        //Se indican las constraints del botonRespuestaTres
        NSLayoutConstraint.activate([buttonRespuestaTres.topAnchor.constraint(equalTo: buttonRespuestaUno.bottomAnchor, constant: 20), buttonRespuestaTres.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), buttonRespuestaTres.widthAnchor.constraint(equalToConstant: buttonAncho), buttonRespuestaTres.heightAnchor.constraint(equalToConstant: buttonLargo)])
        buttonRespuestaTres.addTarget(self, action: #selector(buttonOpcion), for: .touchUpInside)
        
        //Se indica el tag del botonRespuestaCuatro
        buttonRespuestaCuatro = buttonRespuesta(tag: 3)
        
        addSubview(buttonRespuestaCuatro)
        
        //Se indican las constraints del botonRespuestaCuatro
        NSLayoutConstraint.activate([buttonRespuestaCuatro.topAnchor.constraint(equalTo: buttonRespuestaTres.topAnchor), buttonRespuestaCuatro.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), buttonRespuestaCuatro.widthAnchor.constraint(equalToConstant: buttonAncho), buttonRespuestaCuatro.heightAnchor.constraint(equalToConstant: buttonLargo)])
        buttonRespuestaCuatro.addTarget(self, action: #selector(buttonOpcion), for: .touchUpInside)
    }
    
    //Atributos de los botones respuesta
    func buttonRespuesta(tag: Int) -> UIButton {
        let buttonRespuesta = UIButton()
        buttonRespuesta.tag = tag
        buttonRespuesta.setTitle("Opcion", for: .normal)
        buttonRespuesta.setTitleColor(UIColor.black, for: .normal)
        buttonRespuesta.backgroundColor = UIColor.white
        buttonRespuesta.layer.borderWidth = 1
        buttonRespuesta.layer.borderColor = UIColor.darkGray.cgColor
        buttonRespuesta.layer.cornerRadius = 5
        buttonRespuesta.clipsToBounds = true
        buttonRespuesta.translatesAutoresizingMaskIntoConstraints = false
        return buttonRespuesta
    }
    
    //Atributos del label pregunta
    let labelPregunta: UILabel = {
        let labelPregunta = UILabel()
        labelPregunta.text = "Pregunta"
        labelPregunta.textColor = UIColor.black
        labelPregunta.textAlignment = .center
        labelPregunta.font = UIFont.systemFont(ofSize: 24)
        labelPregunta.numberOfLines = 4
        labelPregunta.translatesAutoresizingMaskIntoConstraints=false
        return labelPregunta
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) no ha sido implementado")
    }
}
