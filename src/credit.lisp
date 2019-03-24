(defclass Credit() (
  (period
    :initarg :period
    :accessor period
    :initform 30
  )
  (interest-rate
    :initarg :interest-rate
    :accessor interest-rate
  )
  (currency
    :initarg :currency
    :accessor currency
  )
))