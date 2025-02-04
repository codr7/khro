(cl:defpackage khro
  (:import-from cl assert not)
  (:export = + - assert not))

(cl:in-package khro)

(cl:defmacro do-pairs1 ((x y in) cl:&body body)
  (cl:let ((next (cl:gensym)))
    `(cl:let ((in ,in))
       (cl:tagbody
	,next
	  (cl:let ((,x (cl:pop in))
		   (,y (cl:first in)))
	    (cl:when (cl:or ,x ,y)
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

(cl:defmethod = ((x cl:number) cl:&rest args)
  (cl:apply #'cl:= x args))

(cl:defmethod = ((x cl:string) cl:&rest args)
  (do-pairs1 (x y (cl:cons x args))
    (cl:unless (cl:string= x y)
      (cl:return-from = cl:nil)))
  cl:t)

(cl:defmethod = ((x cl:list) cl:&rest args)
  (do-pairs1 (l1 l2 (cl:cons x args))
    (do-pairs2 (x l1 y l2)
      (cl:unless (= x y)
	(cl:return-from = cl:nil))))
  cl:t)


(cl:defmethod = (x cl:&rest args)
  (cl:apply #'cl:eq x args))


(cl:defmethod + ((x cl:number) cl:&rest args)
  (cl:apply #'cl:+ x args))

(cl:defmethod - ((x cl:number) cl:&rest args)
  (cl:apply #'cl:- x args))
