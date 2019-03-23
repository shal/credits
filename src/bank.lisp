;; Classes

;; Base Bank Class.
(defclass Bank()
  (
    (name
      :initarg :name
      :accessor name
    )
    (credits
      :initarg :credits
      :accessor credits
    )
  )
)

;; MonoBank Class.
(defclass Mono(Bank)
  (
    (name
      :initarg :name
      :accessor name
      :initform "MonoBank"
    )
  )
)

;; PrivatBank Class.
(defclass Privat(Bank)
  (
    (name
      :initarg :name
      :accessor name
      :initform "PrivatBank"
    )
  )
)

;; UniversalBank Class.
(defclass Universal(Bank)
  (
    (name
      :initarg :name
      :accessor name
      :initform "UniversalBank"
    )
  )
)