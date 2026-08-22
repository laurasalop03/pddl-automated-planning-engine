; LAURA SALAS LOPEZ

(define (problem problema1) 
    (:domain dominio1)

    (:objects 
        ; Localizaciones del mapa
        Hobbiton Bree Rivendell HighPass Mirkwood Erebor Moria Lothlorien Tharbad Fangorn Isengard - Localizacion
        HelmsDeep Edoras AmonHen MinasTirith DolAmroth Tolfolas MinasMorgul DeadMarshes Orodruin - Localizacion
        
        ; Personajes
        Enano1 Enano2 Hobbit1 - Personaje
        
        ; Nodos donde están los materiales (solo Mithril y Alimentos porque son los únicos necesarios en este ejercicio)
        ; Esto reduce significativamente el espacio de búsqueda.
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
        ; Por la Hipótesis del Mundo Cerrado de PDDL, todo lo que no se declara explícitamente en el :init se asume como falso.

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
    )

    (:goal (and
        ; Tiene que haber un personaje asignado a un nodo de Mithril y otro a uno de Alimento.
        ; En lugar de usar exists, que da error porque FD lo traduce a axiomas, simplemente comprobamos 
        ; que recursoExtraido es cierto para ambos recursos.
        (recursoExtraido Mithril)
        (recursoExtraido Alimento)
    ))
)
