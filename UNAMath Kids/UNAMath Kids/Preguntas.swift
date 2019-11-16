//
//  Preguntas.swift
//  UNAMath Kids
//
//  Created by MacOS Mojave on 11/15/19.
//  Copyright © 2019 JAGS. All rights reserved.
//

import UIKit

//Se declaran las constantes y variables de preguntas, respuestas, correctas, incorrectas y contestadas
struct Pregunta {
    let preguntas: String
    let respuestas: [String]
    let correctas: Int
    var incorrectas: Int
    var contestadas: Bool
}

class Preguntas: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Se declara el arreglo de preguntas, el puntaje y la pregunta actual
    var vistaColeccion: UICollectionView!
    var arregloPreguntas = [Pregunta]()
    var puntaje: Int = 0
    var preguntaActual = 1
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Atributos del layout
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        //Atributos de la vista
        vistaColeccion = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        vistaColeccion.delegate = self
        vistaColeccion.dataSource = self
        vistaColeccion.register(Respuestas.self, forCellWithReuseIdentifier: "Cell")
        vistaColeccion.showsHorizontalScrollIndicator = false
        vistaColeccion.translatesAutoresizingMaskIntoConstraints = false
        vistaColeccion.backgroundColor = UIColor.white
        vistaColeccion.isPagingEnabled = true
        
        self.view.addSubview(vistaColeccion)
        
        //Se pueden agregar tantas preguntas como se desee al arreglo
        //Se declaran las constantes que apareceran como pregunta, el texto de la pregunta y las respuestas de la pregunta
        //Se indican las correctas, incorrectas y las preguntas contestadas
        let preguntaUno = Pregunta(preguntas: "2 x 2", respuestas: ["2", "4", "8", "6"], correctas: 1, incorrectas: -1, contestadas: false)
        let preguntaDos = Pregunta(preguntas: "4 + 2", respuestas: ["9", "4", "3", "6"], correctas: 3, incorrectas: -1, contestadas: false)
        let preguntaTres = Pregunta(preguntas: "2 - 2", respuestas: ["2", "4", "1", "0"], correctas: 3, incorrectas: -1, contestadas: false)
        let preguntaCuatro = Pregunta(preguntas: "12 x 2", respuestas: ["24", "40", "26", "34"], correctas: 0, incorrectas: -1, contestadas: false)
        let preguntaCinco = Pregunta(preguntas: "6 / 2", respuestas: ["12", "0", "3", "9"], correctas: 2, incorrectas: -1, contestadas: false)
        
        //Se meten las preguntas al arreglo preguntas
        arregloPreguntas = [preguntaUno, preguntaDos, preguntaTres, preguntaCuatro, preguntaCinco]
        
        //Se ejecuta la función configurarVista()
        configurarVista()
    }
    
    //Se cuenta el número de preguntas en el arreglo
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arregloPreguntas.count
    }
    
    //Se indica la fila de las respuestas a la pregunta realizada
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Respuestas
        celda.pregunta = arregloPreguntas[indexPath.row]
        celda.delegate = self
        return celda
    }
    
    //Se ejecuta la función numeroPregunta()
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        numeroPregunta()
    }
    
    //Función numeroPregunta la cual acumula las preguntas segun se vayan respondiendo
    //Se muestra el número de la pregunta en un label
    func numeroPregunta() {
        let x = vistaColeccion.contentOffset.x
        let width = vistaColeccion.bounds.size.width
        let paginaActual = Int(ceil(x / width))
        
        if paginaActual < arregloPreguntas.count {
            labelNumeroPregunta.text = "Pregunta: \(paginaActual + 1) / \(arregloPreguntas.count)"
            preguntaActual = paginaActual + 1
        }
    }
    
    //Función que asigna el puntaje total al resultado dependiendo de la pregunta que se haya respondido
    @objc func buttonPreguntas(sender: UIButton) {
        
        //Si el sender es igual al botoSiguiente y a la preguntaActual entonces seria igual al número de preguntas en el arreglo
        if sender == buttonSiguiente && preguntaActual == arregloPreguntas.count {
            let resultado = Resultado()
            resultado.puntaje = puntaje
            resultado.puntajeTotal = arregloPreguntas.count
            self.navigationController?.pushViewController(resultado, animated: false)
            return
        }
        
        let collectionBounds = self.vistaColeccion.bounds
        var contentOffset: CGFloat = 0
        
        //Si el sender es igual al botonSiguiente entonces se suma la pregunta actual y tiene que ser mayor o igual al número de preguntas en el arreglo
        if sender == buttonSiguiente {
            contentOffset = CGFloat(floor(self.vistaColeccion.contentOffset.x + collectionBounds.size.width))
            preguntaActual += preguntaActual >= arregloPreguntas.count ? 0 : 1
            
            //Si el sender no es igual al botonSiguiente entonces se le resta la pregunta actual y deberá ser menor o igual a cero
        } else {
            contentOffset = CGFloat(floor(self.vistaColeccion.contentOffset.x - collectionBounds.size.width))
            preguntaActual -= preguntaActual <= 0 ? 0 : 1
        }
        
        
        self.pasarPregunta(contentOffset: contentOffset)
        
        //Label que muestra la pregunta actual que se obtiene del arreglo
        labelNumeroPregunta.text = "Pregunta: \(preguntaActual) / \(arregloPreguntas.count)"
    }
    
    //Función que anima el pasar de las preguntas
    func pasarPregunta(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset, y : self.vistaColeccion.contentOffset.y, width : self.vistaColeccion.frame.width, height : self.vistaColeccion.frame.height)
        self.vistaColeccion.scrollRectToVisible(frame, animated: true)
    }
    
    //Función donde se establecen las constraints de la vista, botón Anterior, botón Siguiente y los labels de Numero de Preguntas y Puntaje
    func configurarVista() {
        vistaColeccion.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        vistaColeccion.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vistaColeccion.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        vistaColeccion.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(buttonAnterior)
        buttonAnterior.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonAnterior.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        buttonAnterior.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        buttonAnterior.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.view.addSubview(buttonSiguiente)
        buttonSiguiente.heightAnchor.constraint(equalTo: buttonAnterior.heightAnchor).isActive = true
        buttonSiguiente.widthAnchor.constraint(equalTo: buttonAnterior.widthAnchor).isActive = true
        buttonSiguiente.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        buttonSiguiente.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.view.addSubview(labelNumeroPregunta)
        labelNumeroPregunta.heightAnchor.constraint(equalToConstant: 20).isActive = true
        labelNumeroPregunta.widthAnchor.constraint(equalToConstant: 150).isActive = true
        labelNumeroPregunta.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        labelNumeroPregunta.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        labelNumeroPregunta.text = "Pregunta: \(1) / \(arregloPreguntas.count)"
        
        self.view.addSubview(labelPuntaje)
        labelPuntaje.heightAnchor.constraint(equalTo: labelNumeroPregunta.heightAnchor).isActive = true
        labelPuntaje.widthAnchor.constraint(equalTo: labelNumeroPregunta.widthAnchor).isActive = true
        labelPuntaje.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        labelPuntaje.bottomAnchor.constraint(equalTo: labelNumeroPregunta.bottomAnchor).isActive = true
        labelPuntaje.text = "Puntaje: \(puntaje) / \(arregloPreguntas.count)"
    }
    
    //Atributos del botón Anterior
    let buttonAnterior: UIButton = {
        let buttonAnterior = UIButton()
        buttonAnterior.setTitle("< Anterior", for: .normal)
        buttonAnterior.setTitleColor(UIColor.white, for: .normal)
        buttonAnterior.backgroundColor = UIColor.orange
        buttonAnterior.translatesAutoresizingMaskIntoConstraints = false
        buttonAnterior.addTarget(self, action: #selector(buttonPreguntas), for: .touchUpInside)
        return buttonAnterior
    }()
    
    //Atributos del botón Siguiente
    let buttonSiguiente: UIButton = {
        let buttonSiguiente = UIButton()
        buttonSiguiente.setTitle("Siguiente >", for: .normal)
        buttonSiguiente.setTitleColor(UIColor.white, for: .normal)
        buttonSiguiente.backgroundColor = UIColor.purple
        buttonSiguiente.translatesAutoresizingMaskIntoConstraints = false
        buttonSiguiente.addTarget(self, action: #selector(buttonPreguntas), for: .touchUpInside)
        return buttonSiguiente
    }()
    
    //Atributos del label Numero Pregunta
    let labelNumeroPregunta: UILabel = {
        let labelNumeroPreguntas = UILabel()
        labelNumeroPreguntas.text = "0 / 0"
        labelNumeroPreguntas.textColor = UIColor.gray
        labelNumeroPreguntas.textAlignment = .left
        labelNumeroPreguntas.font = UIFont.systemFont(ofSize: 16)
        labelNumeroPreguntas.translatesAutoresizingMaskIntoConstraints = false
        return labelNumeroPreguntas
    }()
    
    //Atributos del label Puntaje
    let labelPuntaje: UILabel = {
        let labelPuntaje = UILabel()
        labelPuntaje.text = "0 / 0"
        labelPuntaje.textColor = UIColor.gray
        labelPuntaje.textAlignment = .right
        labelPuntaje.font = UIFont.systemFont(ofSize: 16)
        labelPuntaje.translatesAutoresizingMaskIntoConstraints = false
        return labelPuntaje
    }()
}

//Función que suma o resta el puntaje dependiendo si respondió bien o mal la pregunta
extension Preguntas: CeldasPreguntas {
    
    func eligioRespuesta(indexRespuestas: Int) {
        
        let centerIndex = getCenterIndex()
        guard let index = centerIndex else { return }
        
        arregloPreguntas[index.item].contestadas = true
        
        if arregloPreguntas[index.item].correctas != indexRespuestas {
            arregloPreguntas[index.item].incorrectas = indexRespuestas
            puntaje -= 1
        } else {
            puntaje += 1
        }
        
        labelPuntaje.text = "Puntaje: \(puntaje) / \(arregloPreguntas.count)"
        vistaColeccion.reloadItems(at: [index])
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.vistaColeccion.center, to: self.vistaColeccion)
        let index = vistaColeccion!.indexPathForItem(at: center)
        return index
    }
}
