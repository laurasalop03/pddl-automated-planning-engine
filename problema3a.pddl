; LAURA SALAS LOPEZ

(define (problem problema3a) 
    (:domain dominio3a)

    (:objects 
        ; Localizaciones del mapa
        Hobbiton Bree Rivendell HighPass Mirkwood Erebor Moria Lothlorien Tharbad Fangorn Isengard - Localizacion
        HelmsDeep Edoras AmonHen MinasTirith DolAmroth Tolfolas MinasMorgul DeadMarshes Orodruin - Localizacion
        
        ; Personajes
        Enano1 Enano2 Hobbit1 Hobbit2 Hobbit3 Hobbit4 Mago1 Mago2 Elfo1 - Personaje
        
        ; Nodos donde están los materiales (solo Mithril y Alimentos porque son los únicos necesarios en este ejercicio)
        NodoMithrilMoria NodoAlimentoHobbiton - Recurso
    )

    (:init
        ; Asignamos a cada personaje su tipo
        (personajeEs Enano1 Enano)
        (personajeEs Enano2 Enano)
        (personajeEs Hobbit1 Hobbit)
        (personajeEs Hobbit2 Hobbit)
        (personajeEs Hobbit3 Hobbit)
        (personajeEs Hobbit4 Hobbit)
        (personajeEs Mago1 Mago)
        (personajeEs Mago2 Mago)
        (personajeEs Elfo1 Elfo)

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
        (en Enano1 Moria)
        (en Enano2 Fangorn)
        (en Hobbit1 Hobbiton)
        (en Hobbit2 Hobbiton)
        (en Hobbit3 Hobbiton)
        (en Hobbit4 Bree)
        (en Mago1 Rivendell)
        (en Mago2 Isengard)
        (en Elfo1 Lothlorien)

        ; Añadimos la disponibilidad
        (disponible Enano1)
        (disponible Enano2)
        (disponible Hobbit1)
        (disponible Hobbit2)
        (disponible Hobbit3)
        (disponible Hobbit4)
        (disponible Mago1)
        (disponible Mago2)
        (disponible Elfo1)

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

        ; Marcamos cada objeto como lo que es
        (esAnillo Anillo)
        (esEquipamiento ChalecoMithril)
        (esEquipamiento Espada)

        ; El anillo se encuentra en Rivendell
        (en Anillo Rivendell)

        ; La espada está en Lothlorien
        (en Espada Lothlorien)

        ; El chaleco no se marca como que está en Moria porque aún no está materializado.
        ; Una vez se ejecute la acción materializarChaleco, aparecerá allí.

        ; El anillo hay que llevarlo a Orodruin para destruirlo 
        (lugarDestruccion Orodruin)
    )

    (:goal 
        ; El único objetivo es que el anillo sea destruido.
        (anilloDestruido)
    )
)
