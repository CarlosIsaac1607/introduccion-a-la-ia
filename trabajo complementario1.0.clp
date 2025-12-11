;;========================================================
;; TAREA COMPLEMENTARIA
;;========================================================

(deftemplate mensaje
   (slot texto))

(deftemplate clasificacion
   (slot tipo))

;;========================================================
;; LISTA DE SALUDOS RECOLECTADOS (20 ejemplos)
;;========================================================

(defglobal ?*saludos* = 
   (create$ 
      "hola"
      "holaa"
      "holaaa"
      "ola"
      "holi"
      "hello"
      "hi"
      "que onda"
      "buenas"
      "buenas tardes"
      "buenos dias"
      "buenas noches"
      "saludos"
      "qué tal"
      "como andas"
      "welcome"
      "bienvenido"
      "bienvenida"
      "👋"
      "hey"
   )
)

;;========================================================
;; REGLAS DE CLASIFICACIÓN DE SALUDOS
;;========================================================

;; Regla 1: saludos EXACTOS contenidos en la lista
(defrule saludo-exacto
   (mensaje (texto ?t))
   (test (member$ ?t ?*saludos*))
   =>
   (assert (clasificacion (tipo "saludo")))
   (printout t "Sistema: ¡Hola! ¿Cómo estás?" crlf)
)

;; Regla 2: saludos largos con palabras clave
(defrule saludo-palabras-clave
   (mensaje (texto ?t))
   (test (or
           (str-index "buenas" ?t)
           (str-index "buenos" ?t)
           (str-index "saludos" ?t)
           (str-index "hola" ?t)
           (str-index "hey" ?t)
           (str-index "hi" ?t)
           (str-index "hello" ?t)
        ))
   =>
   (assert (clasificacion (tipo "saludo")))
   (printout t "Sistema: ¡Qué gusto saludarte! 😊" crlf)
)

;; Regla 3: saludos de bienvenida
(defrule saludo-bienvenida
   (mensaje (texto ?t))
   (test (or
           (str-index "bienvenido" ?t)
           (str-index "bienvenida" ?t)
           (str-index "welcome" ?t)
        ))
   =>
   (assert (clasificacion (tipo "saludo")))
   (printout t "Sistema: ¡Bienvenido! ¿En qué te ayudo hoy?" crlf)
)

;; Regla 4: saludos con emojis
(defrule saludo-emoji
   (mensaje (texto ?t))
   (test (or
           (str-index "👋" ?t)
           (str-index ":)" ?t)
           (str-index ":D" ?t)
        ))
   =>
   (assert (clasificacion (tipo "saludo")))
   (printout t "Sistema: ¡Hola! Veo que vienes con buena vibra 😄" crlf)
)

;;========================================================
;; MENSAJES NO RECONOCIDOS
;;========================================================

(defrule no-entendido
   (mensaje (texto ?t))
   (not (clasificacion (tipo "saludo")))
   =>
   (printout t "Sistema: No entendí tu mensaje, ¿puedes repetirlo?" crlf)
)

;;========================================================
;; LOOP DE INTERACCIÓN
;;========================================================

(defrule iniciar
   =>
   (printout t "Sistema iniciado. Escribe un mensaje:" crlf)
   (bind ?input (readline))
   (assert (mensaje (texto ?input))))
