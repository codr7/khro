(cl:defpackage khro-tests
  (:use khro)
  (:export run))

(cl:in-package khro-tests)

(cl:defun test-T? ()
  (assert (T? 1))
  (assert (not (T? 0)))
  
  (assert (T? "abc"))
  (assert (not (T? "")))

  (assert (T? '(1 2 3)))
  (assert (not (T? '()))))

(cl:defun test= ()
  (assert (= 6 (+ 1 2 3)))
  (assert (= -4 (- 1 2 3)))

  (assert (= "abc" "abc" "abc"))
  (assert (not (= "abc" "abc" "def")))

  (assert (= '(1 2 3) '(1 2 3)))
  (assert (not (= '(1 2 3) '(1 2)))))
  
(cl:defun run ()
  (test-T?)
  (test=))
