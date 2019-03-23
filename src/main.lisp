
;; (compile-file "lib/ltk/ltk.lisp")
(load "lib/ltk/ltk.lisp")
(in-package :ltk)

(load "src/bank.lisp")

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

;;; Reads file content into string.
;; (defun lines (filename)
;;   (with-open-file (stream filename)
;;     (let
;;       (
;;         (contents (make-string (file-length stream)))
;;       )

;;       (read-sequence contents stream)
;;       contents
;;     )
;;   )
;; )

;; (defun lines (filename)
;;   (with-temp-buffer
;;     (insert-file-contents filename)
;;     (split-string
;;       (buffer-substring-no-properties 1 (point-max)) "\n" t)
;;     )
;;   )

;; Reads file content into string.
(defun content (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents
    )
  )
)

;; Splits string into array of strings by dot.
(defun get-lines (string)
  (loop for start = 0 then (1+ finish)
    for finish = (position #\Newline string :start start)
    collecting (subseq string start finish)
    until (null finish)
  )
)

;; GUI
(defun gui()
  (with-ltk ()
    (let*
      (
        (lines (get-lines (content "./data/credits.txt")))
        (f (make-instance 'frame))
        (ftop (make-instance 'frame :master f))
        (fleft (make-instance 'frame :master ftop))
        (fright (make-instance 'frame :master ftop))

        (txtsearch (make-instance 'text :master fleft))

        (sbutton (make-instance 'button :master fright
                                        :text "Search"
                                        :command (lambda () (format t "Search~&"))))

        (okbutton (make-instance 'button :master fright
                                         :text "OK"
                                         :command (lambda () (format t "OK~&"))))

        (credits (make-instance 'listbox :master f
                                         :borderwidth 0))
      )

      (listbox-append credits lines)
      (listbox-select credits 1)

      ;;; Build the GUI.
      (pack f)
      (pack ftop)
      (pack fleft :side :left)
      (pack fright :side :right)

      (pack txtsearch)
      (pack sbutton :side :left)
      (pack okbutton :side :right)

      (configure txtsearch :width 38)
      (configure txtsearch :height 1)

      (pack credits :after ftop)

      (configure credits :width 50)
      (configure credits :height 30)

      ;; (configure f :borderwidth 3)
      ;; (configure f :relief :sunken)
    )
  )
)

(gui)

(defvar mono (make-instance 'Mono))
(format t "~a~%" (name mono))