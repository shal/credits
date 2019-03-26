(load "lib/ltk/ltk.lisp")
(load "src/bank.lisp")

(in-package :ltk)

(defun content (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents
    )
  )
)

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
        (choosen-credit (make-instance 'label :master f :text "Nothing"))
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
                                              (setf (text choosen-credit) (nth (car selected-credit) lines))
                                              (with-open-file (stream "./data/user_data.txt" :direction :output)
                                                (format stream "~a" (car selected-credit))
                                              )
                                            )
                                          )))
      )

      (listbox-append list-of-credits lines)
      ;; Show right selected value.
      (let
        (
          (selected-credit (parse-integer (content "./data/user_data.txt")))
        )
        (listbox-select list-of-credits selected-credit)
        (setf (text choosen-credit) (nth selected-credit lines))
      )

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

      (pack choosen-credit :after top-frame)
      (pack list-of-credits :after choosen-credit)

      (configure list-of-credits :width 50)
      (configure list-of-credits :height 30)
    )
  )
)

(gui)
