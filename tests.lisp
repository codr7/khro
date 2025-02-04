(cl:defpackage khro-tests
  (:use khro)
  (:export run))

(cl:in-package khro-tests)

(cl:defun run ()
  (assert (= 6 (+ 1 2 3)))
  (assert (= -4 (- 1 2 3)))
  (assert (= "abc" "abc" "abc"))
  (assert (not (= "abc" "abc" "def"))))
  
