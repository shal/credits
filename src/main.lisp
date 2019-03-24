(load "lib/ltk/ltk.lisp")
(load "src/bank.lisp")

(in-package :ltk)

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
(defun read-lines (string)
  (loop for start = 0 then (1+ finish)
    for finish = (position #\Newline string :start start)
    collecting (subseq string start finish)
    until (null finish)
  )
)

(defun string-include (needle haystack &key (test 'char=))
  (search (string needle) (string haystack) :test test)
)

;; GUI
(defun gui()
  (with-ltk ()
    (let*
      (
        (lines (read-lines (content "./data/credits.txt")))
        (f (make-instance 'frame))
        (top-frame (make-instance 'frame :master f))
        (left-frame (make-instance 'frame :master top-frame))
        (right-frame (make-instance 'frame :master top-frame))
        (list-of-credits (make-instance 'listbox :master f :borderwidth 0))
        (search-field (make-instance 'text :master left-frame))
        (search-button (make-instance 'button :master right-frame
                                        :text "Search"
                                        :command (lambda ()
                                          (listbox-clear list-of-credits)
                                            (let
                                              (
                                                (search-text (string-trim '(#\newline) (text search-field)))
                                              )
                                              (listbox-append list-of-credits
                                                (remove-if (lambda (x)
                                                  (not (string-include search-text x))
                                                ) lines)
                                              )
                                            )
                                          )))

        (okbutton (make-instance 'button :master right-frame
                                         :text "OK"
                                         :command (lambda ()
                                            (let
                                              (
                                                (selected-credit (listbox-get-selection list-of-credits))
                                              )
                                              ;; TODO: Find real index of value.
                                              (with-open-file (stream "./data/user_data.txt" :direction :output)
                                                (format stream "~a" (car selected-credit))
                                              )
                                            )
                                          )
                                        ))
      )

      (listbox-append list-of-credits lines)
      ;; Show right selected value.
      (listbox-select list-of-credits (parse-integer (content "./data/user_data.txt")))

      ;;; Build the GUI.
      (pack f)
      (pack top-frame)
      (pack left-frame :side :left)
      (pack right-frame :side :right)

      (pack search-field)
      (pack search-button :side :left)
      (pack okbutton :side :right)

      (configure search-field :width 38)
      (configure search-field :height 1)

      (pack list-of-credits :after top-frame)

      (configure list-of-credits :width 50)
      (configure list-of-credits :height 30)
    )
  )
)

(gui)
