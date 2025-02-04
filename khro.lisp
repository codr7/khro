(cl:defpackage khro
  (:import-from cl assert not)
  (:export = + - assert not))

(cl:in-package khro)

(cl:defmacro do-pairs ((x y in) cl:&body body)
  `(cl:let ((in ,in))
     (cl:tagbody
      next
	(cl:let ((,x (cl:pop in))
		 (,y (cl:first in)))
	  (cl:when (cl:and ,x ,y)
	    ,@body
	    (cl:go next))))))


(cl:defmethod = ((x cl:number) cl:&rest args)
  (cl:apply #'cl:= x args))

(cl:defmethod = ((x cl:string) cl:&rest args)
  (do-pairs (x y (cl:cons x args))
    (cl:unless (cl:string= x y)
      (cl:return-from = cl:nil)))
  cl:t)
      

(cl:defmethod = (x cl:&rest args)
  (cl:apply #'cl:eq x args))


(cl:defmethod + ((x cl:number) cl:&rest args)
  (cl:apply #'cl:+ x args))

(cl:defmethod - ((x cl:number) cl:&rest args)
  (cl:apply #'cl:- x args))
