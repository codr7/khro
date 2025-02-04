(cl:defpackage khro
  (:import-from cl assert not)
  (:import-from utils do-pairs1 do-pairs2)
  (:export = + - assert not))

(cl:in-package khro)

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
      (cl:unless (cl:and (cl:and x y) (= x y))
	(cl:return-from = cl:nil))))
  cl:t)


(cl:defmethod = (x cl:&rest args)
  (cl:apply #'cl:eq x args))


(cl:defmethod + ((x cl:number) cl:&rest args)
  (cl:apply #'cl:+ x args))

(cl:defmethod - ((x cl:number) cl:&rest args)
  (cl:apply #'cl:- x args))
