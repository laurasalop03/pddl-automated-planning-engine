; LAURA SALAS LOPEZ

(define (domain dominio1)

    (:requirements :strips :typing :adl)

    ; He optado por separar los tipos instanciables (Localizacion, Personaje, Recurso) 
    ; de los tipos abstractos (tipoPersonaje, tipoRecurso). Esto permite asignar 
    ; dinámicamente qué personaje puede extraer qué recurso mediante el predicado (puedeExtraer).
    ; Además, he creado el predicado (recursoExtraido) para evitar el uso de cuantificadores 
    ; existenciales (exists) en el :goal, ya que Fast Downward los traduce a axiomas 
    ; que no están soportados por el alias seq-opt-lmcut.

    (:types 
        ; Separo los tipos en los que se pueden ubicar (personajes y recursos) del resto,
        ; porque así podemos comprobar si hay algo en una localización más fácil. 
        ; También añado los tipos tipoPersonaje y tipoRecurso, pues hay restricciones sobre
        ; qué personaje puede extraer qué tipo de recurso, por lo que es necesario hacer+
        ; esta distinción.

        Localizacion tipoPersonaje tipoRecurso Ubicable - object
        Personaje Recurso - Ubicable
    )

    (:constants
        ; Constantes para los tipos de personaje y tipos de recurso
        Enano Hobbit - tipoPersonaje
        Mineral Mithril Madera Especia Alimento - tipoRecurso
    )

    (:predicates 
        ; Determinar si un personaje o nodo de recurso concreto está en una localización determinada.
        (en ?obj - Ubicable ?loc - Localizacion)

        ; Representar que existe un camino entre dos localizaciones.
        (camino ?origen - Localizacion ?destino - Localizacion)

        ; Determinar si un personaje está trabajando en una localización extrayendo un recurso.
        (trabajando ?per - Personaje ?loc - Localizacion ?rec - tipoRecurso)

        ; Identificar si un personaje está disponible (es decir, no está trabajando).
        (disponible ?per - Personaje)

        ; Determinar que un tipo de personaje puede extraer un recurso.
        (puedeExtraer ?tipoPer - tipoPersonaje ?tipoRec - tipoRecurso)

        ; Predicados auxiliares necesarios para asociar los objetos con sus constantes.
        (personajeEs ?per - Personaje ?tipo - tipoPersonaje)
        (recursoEs ?rec - Recurso ?tipo - tipoRecurso)

        ; Predicado que se activa cuando un personaje se pone a trabajar en un recurso.
        ; Necesario para eliminar los exists de :goal.
        (recursoExtraido ?tipoRec - tipoRecurso)

        ; Indica si un camino se destruye al transitarlo.
        (caminoFragil ?origen - Localizacion ?destino - Localizacion)
    )

    ; Acción Viajar
    ; Mueve a un personaje entre dos localizaciones.
    (:action Viajar
        :parameters (?per - Personaje ?origen - Localizacion ?destino - Localizacion)
        :precondition (and 
            ; el personaje debe estar en la localización de origen
            (en ?per ?origen)
            ; debe existir un camino entre origen y destino
            (camino ?origen ?destino)
            ; el personaje tiene que estar disponible
            (disponible ?per)
        )
        :effect (and 
            ; el personaje pasa a estar en la localización de destino
            (en ?per ?destino)
            ; deja de estar en el origen
            (not (en ?per ?origen))

            ; si el camino es frágil, se destruye en ambas direcciones al pasar.
            (when (caminoFragil ?origen ?destino)
                (and 
                    (not (camino ?origen ?destino))
                    (not (camino ?destino ?origen))
                )
            )
        )
    )

    ; Acción ExtraerRecurso
    ; Asigna un personaje a un nodo de recurso.
    (:action ExtraerRecurso
        :parameters (?per - Personaje ?loc - Localizacion ?tipoRec - tipoRecurso)
        :precondition (and 
            ; el personaje tiene que estar disponible
            (disponible ?per)
            ; el personaje tiene que estar en la localización donde está el recurso
            (en ?per ?loc)

            ; tiene que existir un nodo del recurso pedido en la localización dada
            (exists (?nodo - Recurso) 
                (and 
                    (en ?nodo ?loc)
                    (recursoEs ?nodo ?tipoRec)
                )
            )

            ; el personaje tiene que poder extraer el tipo de recurso pedido
            (exists (?tipoPer - tipoPersonaje)
                (and
                    (personajeEs ?per ?tipoPer)
                    (puedeExtraer ?tipoPer ?tipoRec)
                )
            )
        )
        :effect (and 
            ; el personaje deja de estar disponible
            (not (disponible ?per))
            ; marcamos como que está trabajando extrayendo el recurso
            (trabajando ?per ?loc ?tipoRec)
            ; marcamos el tipo de recurso como que se está extrayendo
            ; así, en :goal solamente tenemos que mirar que esto es cierto
            ; para Mithril y Alimento
            (recursoExtraido ?tipoRec)
        )
    )
    
    
)