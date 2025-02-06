(cl:defpackage khro-tests
  (:use khro)
  (:export run))

(cl:in-package khro-tests)

(cl:defun test-T? ()
  (check (T? 1))
  (check (not (T? 0)))
  
  (check (T? "abc"))
  (check (not (T? "")))

  (check (T? '(1 2 3)))
  (check (not (T? '()))))

(cl:defun test= ()
  (check (= 6 (+ 1 2 3)))
  (check (= -4 (- 1 2 3)))

  (check (= "abc" "abc" "abc"))
  (check (not (= "abc" "abc" "def")))

  (check (= '(1 2 3) '(1 2 3)))
  (check (not (= '(1 2 3) '(1 2)))))
  
(cl:defun run ()
  (test-T?)
  (test=))
