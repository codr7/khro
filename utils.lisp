(cl:defpackage utils
  (:use cl)
  (:export do-pairs1 do-pairs2))

(cl:in-package utils)

(cl:defmacro do-pairs1 ((x y in) cl:&body body)
  (cl:let ((next (cl:gensym)))
    `(cl:let ((in ,in))
       (cl:tagbody
	,next
	  (cl:let ((,x (cl:pop in))
		   (,y (cl:first in)))
	    (cl:when (cl:and ,x ,y)
	      ,@body
	      (cl:go ,next)))))))

(cl:defmacro do-pairs2 ((x in1 y in2) cl:&body body)
  (cl:let ((next (cl:gensym)))
    `(cl:let ((in1 ,in1)
	      (in2 ,in2))
       (cl:tagbody
	,next
	  (cl:let ((,x (cl:pop in1))
		   (,y (cl:pop in2)))
	    (cl:when (cl:or ,x ,y)
	      ,@body
	      (cl:go ,next)))))))
