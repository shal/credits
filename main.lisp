
;; (compile-file "lib/ltk/ltk.lisp")
(load "lib/ltk/ltk.lisp")
(in-package :ltk)

;; Classes

;;
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

;;
(defclass Mono(Bank)
  (
    (name
      :initarg :name
      :accessor name
      :initform "MonoBank"
    )
  )
)

;;
(defclass Privat(Bank)
  (
    (name
      :initarg :name
      :accessor name
      :initform "PrivatBank"
    )
  )
)

;;
(defclass Universal(Bank)
  (
    (name
      :initarg :name
      :accessor name
      :initform "UniversalBank"
    )
  )
)

;; (defclass Credit() (
;;   (maximum
;;     :initarg :maximum
;;     :accessor maximum)
;;   (minimum
;;     :initarg :minimum
;;     :accessor minimum)
;;   (months
;;     :initarg :months
;;     :accessor months)
;; ))

;; (defvar mono (make-instance 'Mono))
;; (format t "~a~%" (name mono))


        ;; (b1 (make-instance 'button
        ;;                   :text "Print"
        ;;                   :command #'(lambda () (princ (text text-widget)))))
        ;; (b2 (make-instance 'button :text "Reset"
        ;;                   :command #'(lambda () (setf (text text-widget) "reset")))))
  ;; (pack text-widget)
  ;; (pack b1)
  ;; (pack b2))

;; GUI
(defun gui()
  (with-ltk ()
    (let*
      (
        (f (make-instance 'frame))
        (ftop (make-instance 'frame :master f))
        (fleft (make-instance 'frame :master ftop))
        (fright (make-instance 'frame :master ftop))

        (txtsearch (make-instance 'text :master fleft))

        (sbutton (make-instance 'button
                            :master fright
                            :text "Search"
                            :command (lambda () (format t "Search~&"))))

        (okbutton (make-instance 'button
                            :master fright
                            :text "OK"
                            :command (lambda () (format t "OK~&"))))

        (credits (make-instance 'listbox :master f))
      )

      ;;; Add Credits to the listbox.
      (listbox-append credits '("MonoBank 1" "UkrsibBank 2" "PrivatBank 3"))
      (listbox-select credits 1)

      ;;; Build the GUI.
      (pack f)
      (pack ftop)
      (pack fleft :side :left)
      (pack fright :side :right)

      (pack txtsearch)
      (pack sbutton :side :left)
      (pack okbutton :side :right)

      (configure txtsearch :width 50)
      (configure txtsearch :height 1)

      (pack credits :after ftop)

      (configure credits :width 50)
      (configure credits :height 30)

      (configure f :borderwidth 3)
      (configure f :relief :sunken)
    )
  )
)

(gui)