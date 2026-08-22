; LAURA SALAS LOPEZ

(define (domain dominio3c)

    (:requirements :strips :typing :adl)

    (:types 
        ; Separo los tipos en los que se pueden ubicar (personajes, recursos y objetos) del resto,
        ; porque así podemos comprobar si hay algo en una localización más fácil. 
        ; También añado los tipos tipoPersonaje y tipoRecurso, pues hay restricciones sobre
        ; qué personaje puede extraer qué tipo de recurso, por lo que tenemos que distinguir.
        ; Objeto será anillo, chaleco o espada.
        Localizacion tipoPersonaje tipoRecurso Ubicable - object
        Personaje Recurso Objeto - Ubicable
    )

    (:constants
        ; Constantes para los tipos de personaje, tipos de recurso y objetos
        Enano Hobbit Mago Elfo - tipoPersonaje
        Mineral Mithril Madera Especia Alimento - tipoRecurso
        Anillo ChalecoMithril Espada - Objeto
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

        ; Indica si la comunidad ya ha sido creada.
        (comunidadFormada)

        ; Indica si un personaje concreto es miembro de la comunidad.
        (enComunidad ?per - Personaje)

        ; Predicado para saber si un personaje tiene un objeto concreto.
        (tieneObjeto ?per - Personaje ?obj - Objeto)

        ; Predicado para indicar el lugar donde se destruye el anillo.
        (lugarDestruccion ?loc - Localizacion)
        
        ; Indica si el anillo ha sido destruido.
        (anilloDestruido)

        ; Predicados auxiliares para diferenciar el anillo del resto de objetos.
        (esAnillo ?obj - Objeto)
        (esEquipamiento ?obj - Objeto)

        ; Predicado para romper simetrías imponiendo un orden estricto
        (menor ?per1 - Personaje ?per2 - Personaje)

        ; Indica la localización exacta de la comunidad como grupo
        (comunidadEn ?loc - Localizacion)
    )


    ; Acción Viajar
    ; Mueve a un personaje entre dos localizaciones.
    ; Un personaje puede viajar individialmente si no pertenece a la comunidad.
    (:action Viajar
        :parameters (?per - Personaje ?origen - Localizacion ?destino - Localizacion)
        :precondition (and 
            ; el personaje debe estar en la localización de origen
            (en ?per ?origen)
            ; debe existir un camino entre origen y destino
            (camino ?origen ?destino)
            ; el personaje tiene que estar disponible
            (disponible ?per)
            ; el personaje no puede pertenecer a la comunidad
            (not (enComunidad ?per))
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
    
    ; Acción formarComunidad
    ; Forma una comunidad reducida a partir de tres Hobbit y un Mago que están en la misma localización.
    (:action formarComunidad
        :parameters (?hob1 - Personaje ?hob2 - Personaje ?hob3 - Personaje ?mag - Personaje ?loc - Localizacion)
        :precondition (and 
            ; la comunidad no puede estar ya formada
            (not (comunidadFormada))
            ; los personajes tienen que ser tres hobbit y un mago
            (personajeEs ?hob1 Hobbit)
            (personajeEs ?hob2 Hobbit)
            (personajeEs ?hob3 Hobbit)
            (personajeEs ?mag Mago)
            ; tienen que estar en la misma localización
            (en ?hob1 ?loc)
            (en ?hob2 ?loc)
            (en ?hob3 ?loc)
            (en ?mag ?loc)
            ; tienen que estar disponibles
            (disponible ?hob1)
            (disponible ?hob2)
            (disponible ?hob3)
            (disponible ?mag)
            ; los hobbits tienen que ser distintos
            ; forzamos a que se elijan en orden para romper simetrias
            (menor ?hob1 ?hob2)
            (menor ?hob2 ?hob3)
            ; no hace falta poner que el 1 es menor que el 3 por lógica transitiva
        )
        :effect (and 
            ; marcamos la comunidad como formada
            (comunidadFormada)
            ; añadimos a los personajes a la comunidad
            (enComunidad ?hob1)
            (enComunidad ?hob2)
            (enComunidad ?hob3)
            (enComunidad ?mag)
            ; posicionamos a la comunidad en el mapa
            (comunidadEn ?loc)

            ; dejamos de tratar a los personajes individualmente, pues a partir de
            ; ahora siempre se van a mover con la comunidad
            (not (en ?hob1 ?loc))
            (not (en ?hob2 ?loc))
            (not (en ?hob3 ?loc))
            (not (en ?mag ?loc))
        )
    )
    
    ; Acción viajarComunidad
    ; Mueve a todos los miembros de la comunidad juntos.
    (:action viajarComunidad
        :parameters (?hob1 - Personaje ?hob2 - Personaje ?hob3 - Personaje ?mag - Personaje ?origen - Localizacion ?destino - Localizacion)
        :precondition (and 
            ; la comunidad debe estar formada
            (comunidadFormada)
            ; la comunidad tiene que estar en el origen
            (comunidadEn ?origen)
            ; tiene que haber un camino uniendo origen y destino
            (camino ?origen ?destino)
            ; los personajes tienen que ser tres hobbit y un mago
            (personajeEs ?hob1 Hobbit)
            (personajeEs ?hob2 Hobbit)
            (personajeEs ?hob3 Hobbit)
            (personajeEs ?mag Mago)
            ; los hobbits tienen que ser distintos
            ; forzamos a que se elijan en orden para romper simetrias
            (menor ?hob1 ?hob2)
            (menor ?hob2 ?hob3)
            ; no hace falta poner que el 1 es menor que el 3 por lógica transitiva
        )
        :effect (and 
            ; movemos a la comunidad
            (not (comunidadEn ?origen))
            (comunidadEn ?destino)

            ; si el camino es frágil, se destruye en ambas direcciones al pasar
            (when (caminoFragil ?origen ?destino)
                (and 
                    (not (camino ?origen ?destino))
                    (not (camino ?destino ?origen))
                )
            )
        )
    )

    ; Acción materializarChaleco
    ; Crea el chaleco de Mithril en una localización donde se esté extrayendo dicho material.
    (:action materializarChaleco
        :parameters (?mag - Personaje ?loc - Localizacion)
        :precondition (and 
            ; el personaje tiene que ser un mago
            (personajeEs ?mag Mago)
            ; el mago tiene que ser parte de la comunidad
            (enComunidad ?mag)
            ; por lo que la comunidad tiene que estar formada
            (comunidadFormada)
            ; el mago (de la comunidad) tiene que estar en la localización
            (comunidadEn ?loc)
            
            ; comprobamos que alguien esté trabajando en Mithril en esta misma localización
            (exists (?per - Personaje)
                (trabajando ?per ?loc Mithril)
            )
        )
        :effect (and 
            ; el chaleco ahora está en la localización
            ; el chaleco acaba en Moria porque es el único sitio donde se extrae Mithril
            (en ChalecoMithril ?loc)
        )
    )

    ; Acción recogerObjeto
    ; Un personaje de la comunidad recoge un objeto.
    (:action recogerObjeto
        :parameters (?per - Personaje ?loc - Localizacion ?obj - Objeto)
        :precondition (and 
            ; el objeto tiene que estar en la localización
            (en ?obj ?loc)
            ; para recoger los objetos tiene que estar formada la comunidad
            (comunidadFormada)
            ; el personaje (que será un Hobbit, pues es el único que puede coger el anillo y,
            ; por tanto, el único posible portador del anillo) debe pertenecer a la comunidad
            (enComunidad ?per)
            ; el personaje (de la comunidad) tiene que estar en la localización
            (comunidadEn ?loc)
            
            ; separamos los dos casos: recoger el anillo o recoger el chaleco / la espada
            (or 
                ; si es el anillo, el personaje tiene que ser un Hobbit
                (and 
                    (esAnillo ?obj)
                    (personajeEs ?per Hobbit)
                )
                ; si es chaleco o la espada, el personaje tiene ser el portador del anillo 
                ; por lo que será un hobbit también
                (and 
                    (esEquipamiento ?obj)
                    (tieneObjeto ?per Anillo)
                )
            )
        )
        :effect (and 
            ; el objeto desaparece de la localización
            (not (en ?obj ?loc))
            ; el personaje pasa a tener el objeto
            (tieneObjeto ?per ?obj)
        )
    )

    ; Acción destruirAnillo
    ; El portador del anillo lo destruye.
    (:action destruirAnillo
        :parameters (?per - Personaje ?loc - Localizacion)
        :precondition (and 
            ; la localización tiene que ser el lugar de destrucción del anillo
            (lugarDestruccion ?loc)
            ; el personaje tiene que tener los tres objetos
            (tieneObjeto ?per Anillo)
            (tieneObjeto ?per ChalecoMithril)
            (tieneObjeto ?per Espada)
            ; el personaje tiene que estar en la localización
            ; como tiene los 3 objetos, tiene que pertenecer a la comunidad
            ; por lo que podemos cambiar la comprobación por que la comunidad esté
            ; en la localización
            (comunidadEn ?loc)
        )
        :effect (and 
            ; marcamos el anillo como destruido
            (anilloDestruido)
        )
    )
    
)