; LAURA SALAS LOPEZ

(define (problem problema5) 
    (:domain dominio5)

    (:objects 
        ; Localizaciones del mapa
        Hobbiton Bree Rivendell HighPass Mirkwood Erebor Moria Lothlorien Tharbad Fangorn Isengard - Localizacion
        HelmsDeep Edoras AmonHen MinasTirith DolAmroth Tolfolas MinasMorgul DeadMarshes Orodruin - Localizacion
        
        ; Personajes
        Enano1 Enano2 Hobbit1 - Personaje
        
        ; Nodos donde están los materiales (solo Mithril y Alimentos porque son los únicos necesarios en este ejercicio)
        NodoMithrilMoria NodoAlimentoHobbiton - Recurso
    )

    (:init
        ; Asignamos a cada personaje su tipo
        (personajeEs Enano1 Enano)
        (personajeEs Enano2 Enano)
        (personajeEs Hobbit1 Hobbit)

        ; Asignamos los recursos que pueden extraer (solo añado Mithril y Alimento porque son los únicos usados en este ejercicio)
        (puedeExtraer Enano Mithril)
        (puedeExtraer Hobbit Alimento)

        ; Asignamos los tipos de recurso de los nodos
        (recursoEs NodoMithrilMoria Mithril)
        (recursoEs NodoAlimentoHobbiton Alimento)

        ; Posiciones de los nodos
        (en NodoMithrilMoria Moria)
        (en NodoAlimentoHobbiton Hobbiton)

        ; Posiciones iniciales de los personajes
        (en Enano1 Tharbad)
        (en Hobbit1 Lothlorien)
        (en Enano2 Isengard)

        ; Añadimos la disponibilidad
        (disponible Enano1)
        (disponible Hobbit1)
        ; Como Enano2 no está disponible, no pongo nada porque es lo mismo que poner (not (disponible Enano2))

        ; Mapa de caminos (ida y vuelta) - hecho por Gemini
        (camino Hobbiton Bree) (camino Bree Hobbiton)
        (camino Hobbiton Tharbad) (camino Tharbad Hobbiton)
        (camino Bree Rivendell) (camino Rivendell Bree)
        (camino Bree Tharbad) (camino Tharbad Bree)
        (camino Rivendell HighPass) (camino HighPass Rivendell)
        (camino Rivendell Moria) (camino Moria Rivendell)
        (camino HighPass Mirkwood) (camino Mirkwood HighPass)
        (camino Mirkwood Erebor) (camino Erebor Mirkwood)
        (camino Tharbad HelmsDeep) (camino HelmsDeep Tharbad)
        (camino Moria Lothlorien) (camino Lothlorien Moria)
        (camino Lothlorien AmonHen) (camino AmonHen Lothlorien)
        (camino Fangorn Isengard) (camino Isengard Fangorn)
        (camino Fangorn AmonHen) (camino AmonHen Fangorn)
        (camino Isengard HelmsDeep) (camino HelmsDeep Isengard)
        (camino HelmsDeep Edoras) (camino Edoras HelmsDeep)
        (camino Edoras MinasTirith) (camino MinasTirith Edoras)
        (camino Edoras DolAmroth) (camino DolAmroth Edoras)
        (camino AmonHen DeadMarshes) (camino DeadMarshes AmonHen)
        (camino DeadMarshes MinasMorgul) (camino MinasMorgul DeadMarshes)
        (camino MinasTirith MinasMorgul) (camino MinasMorgul MinasTirith)
        (camino MinasTirith Tolfolas) (camino Tolfolas MinasTirith)
        (camino MinasMorgul Orodruin) (camino Orodruin MinasMorgul)
        (camino DolAmroth Tolfolas) (camino Tolfolas DolAmroth)

        ; Añadimos los caminos frágiles, los que una vez han sido usado no podemos volver a pasar
        (caminoFragil Rivendell Moria)
        (caminoFragil Moria Rivendell)

        ; Inicializamos el coste total
        (= (total-cost) 0)

        ; Caminos con coste especial (ida y vuelta) - hecho por Gemini
        (= (distancia Tharbad HelmsDeep) 3) (= (distancia HelmsDeep Tharbad) 3)
        (= (distancia MinasMorgul Orodruin) 3) (= (distancia Orodruin MinasMorgul) 3)
        (= (distancia Rivendell HighPass) 2) (= (distancia HighPass Rivendell) 2)
        (= (distancia Rivendell Moria) 3) (= (distancia Moria Rivendell) 3)
        (= (distancia Lothlorien AmonHen) 5) (= (distancia AmonHen Lothlorien) 5)
        (= (distancia HighPass Mirkwood) 2) (= (distancia Mirkwood HighPass) 2)
        (= (distancia Mirkwood Erebor) 2) (= (distancia Erebor Mirkwood) 2)
        (= (distancia Moria Lothlorien) 3) (= (distancia Lothlorien Moria) 3)
        (= (distancia Fangorn AmonHen) 8) (= (distancia AmonHen Fangorn) 8)
        (= (distancia AmonHen DeadMarshes) 2) (= (distancia DeadMarshes AmonHen) 2)
        (= (distancia DeadMarshes MinasMorgul) 2) (= (distancia MinasMorgul DeadMarshes) 2)
        (= (distancia MinasTirith MinasMorgul) 2) (= (distancia MinasMorgul MinasTirith) 2)
        (= (distancia Edoras MinasTirith) 2) (= (distancia MinasTirith Edoras) 2)
        (= (distancia MinasTirith Tolfolas) 2) (= (distancia Tolfolas MinasTirith) 2)
        (= (distancia Edoras DolAmroth) 2) (= (distancia DolAmroth Edoras) 2)

        ; Caminos con coste unitario (1)
        (= (distancia Hobbiton Bree) 1) (= (distancia Bree Hobbiton) 1)
        (= (distancia Hobbiton Tharbad) 1) (= (distancia Tharbad Hobbiton) 1)
        (= (distancia Bree Rivendell) 1) (= (distancia Rivendell Bree) 1)
        (= (distancia Bree Tharbad) 1) (= (distancia Tharbad Bree) 1)
        (= (distancia Fangorn Isengard) 1) (= (distancia Isengard Fangorn) 1)
        (= (distancia Isengard HelmsDeep) 1) (= (distancia HelmsDeep Isengard) 1)
        (= (distancia HelmsDeep Edoras) 1) (= (distancia Edoras HelmsDeep) 1)
        (= (distancia DolAmroth Tolfolas) 1) (= (distancia Tolfolas DolAmroth) 1)
    )

    (:goal (and
        ; Tiene que haber un personaje asignado a un nodo de Mithril y otro a uno de Alimento.
        ; En lugar de usar exists, que da error porque FD lo traduce a axiomas, simplemente comprobamos 
        ; que recursoExtraido es cierto para ambos recursos.
        (recursoExtraido Mithril)
        (recursoExtraido Alimento)
    ))

    ; métrica para que minimice el coste total
    (:metric 
        minimize (total-cost)
    )
)
