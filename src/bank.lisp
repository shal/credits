;; Classes

;; Base Bank Class.
(defclass Bank()
  (
    (name
      :initarg :name
      :accessor bank-name
    )
    (credits
      :initarg :credits
      :accessor bank-credits
    )
  )
)

;; MonoBank Class.
(defclass Mono(Bank)
  (
    (name
      :reader bank-name
      :initform "MonoBank"
    )
  )
)

;; PrivatBank Class.
(defclass Privat(Bank)
  (
    (name
      :reader bank-name
      :initform "PrivatBank"
    )
  )
)

;; UniversalBank Class.
(defclass Universal(Bank)
  (
    (name
      :reader bank-name
      :initform "UniversalBank"
    )
  )
)