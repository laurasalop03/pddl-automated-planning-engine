; LAURA SALAS LOPEZ

(define (problem problema4) 
    (:domain dominio4)

    (:objects 
        ; Localizaciones del mapa
        Hobbiton Bree Rivendell HighPass Mirkwood Erebor Moria Lothlorien Tharbad Fangorn Isengard - Localizacion
        HelmsDeep Edoras AmonHen MinasTirith DolAmroth Tolfolas MinasMorgul DeadMarshes Orodruin - Localizacion
        
        ; Personajes
        Enano1 Enano2 Hobbit1 Hobbit2 Hobbit3 Hobbit4 Mago1 Mago2 Elfo1 Humano1 Humano2 - Personaje
        Orco1 Orco2 Orco3 Corsario1 Corsario2 - Personaje
        
        ; Nodos donde están los materiales
        NodoMithrilMoria NodoAlimentoHobbiton NodoMineralMoria NodoMineralErebor NodoMaderaFangorn - Recurso
        NodoMaderaLothlorien NodoMaderaMirkwood NodoEspeciasTolfolas - Recurso
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
        (personajeEs Humano1 Humano)
        (personajeEs Humano2 Humano)
        (personajeEs Orco1 Orco)
        (personajeEs Orco2 Orco)
        (personajeEs Orco3 Orco)
        (personajeEs Corsario1 Corsario)
        (personajeEs Corsario2 Corsario)

        ; Asignamos los recursos que pueden extraer
        (puedeExtraer Enano Mithril)
        (puedeExtraer Enano Madera)
        (puedeExtraer Enano Mineral)
        (puedeExtraer Hobbit Alimento)
        (puedeExtraer Orco Mineral)
        (puedeExtraer Orco Madera)
        (puedeExtraer Humano Madera)
        (puedeExtraer Corsario Especia)

        ; Asignamos los tipos de recurso de los nodos
        (recursoEs NodoMithrilMoria Mithril)
        (recursoEs NodoAlimentoHobbiton Alimento)
        (recursoEs NodoMineralMoria Mineral)
        (recursoEs NodoMineralErebor Mineral)
        (recursoEs NodoMaderaFangorn Madera)
        (recursoEs NodoMaderaLothlorien Madera)
        (recursoEs NodoMaderaMirkwood Madera)
        (recursoEs NodoEspeciasTolfolas Especia)

        ; Posiciones de los nodos
        (en NodoMithrilMoria Moria)
        (en NodoAlimentoHobbiton Hobbiton)
        (en NodoMineralMoria Moria)
        (en NodoMineralErebor Erebor)
        (en NodoMaderaFangorn Fangorn)
        (en NodoMaderaLothlorien Lothlorien)
        (en NodoMaderaMirkwood Mirkwood)
        (en NodoEspeciasTolfolas Tolfolas)
    
        ; Posiciones iniciales de los personajes
        (en Enano1 Fangorn)
        (en Enano2 Erebor)
        (en Hobbit1 Hobbiton)
        (en Hobbit2 Hobbiton)
        (en Hobbit3 Hobbiton)
        (en Hobbit4 Bree)
        (en Mago1 Rivendell)
        (en Mago2 Isengard)
        (en Elfo1 Lothlorien)
        (en Humano1 Edoras)
        (en Humano2 Bree)
        (en Orco1 Moria)
        (en Orco2 Moria)
        (en Orco3 Moria)
        (en Corsario1 DolAmroth)
        (en Corsario2 DolAmroth)

        ; Añadimos la disponibilidad (todos disponibles menos el humano en Edoras - Humano1)
        (disponible Enano1)
        (disponible Enano2)
        (disponible Hobbit1)
        (disponible Hobbit2)
        (disponible Hobbit3)
        (disponible Hobbit4)
        (disponible Mago1)
        (disponible Mago2)
        (disponible Humano2)
        (disponible Orco1)
        (disponible Orco2)
        (disponible Orco3)
        (disponible Corsario1)
        (disponible Corsario2)

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

        ; Añadimos los recursos necesarios para cada tipo de edificio
        (necesitaRecurso TorreHechiceria Mineral)
        (necesitaRecurso TorreHechiceria Madera)
        (necesitaRecurso Extractor Madera)
    )

    (:goal (and
        ; Hay que destruir el anillo
        (anilloDestruido)
        ; Se tiene que crear el Uruk-Hai
        (urukhaiCreado)
        ; Un humano tiene que estar en Bree
        (exists (?hum - Personaje) 
            (and 
                (personajeEs ?hum Humano)
                (en ?hum Bree)
            )
        )

        ; Además de estos objetivos, el enunciado nos dice que, para crear un Uruk-Hay, 
        ; hay que construir primero una Torre de Hechicería en Isengard. En lugar de comprobar
        ; esto en la acción Construir o añadir un predicado nuevo, que obligaría a meter más 
        ; precondiciones, pues es una acción genérica tanto para la torre como para el extractor, 
        ; lo añado aquí como objetivo y queda todo más genérico.
        (edificioConstruido TorreHechiceria Isengard)
    ))
)
