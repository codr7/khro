(sb-ext:unlock-package 'common-lisp)

(cl:defpackage khro
  (:import-from cl not)
  (:import-from utils do-pairs1 do-pairs2)
  (:export = + - check not T?))

(cl:in-package khro)

(cl:defmethod T? (x)
  (cl:not (cl:null x)))

(cl:defmethod T? ((x cl:list))
  (cl:not (cl:null (cl:first x))))

(cl:defmethod T? ((x cl:number))
  (cl:not (cl:zerop x)))

(cl:defmethod T? ((x cl:string))
  (cl:not (cl:zerop (cl:length x))))

(cl:defmacro check (cl:&rest conds)
  `(cl:progn
     ,@(cl:mapcar (cl:lambda (c) `(cl:assert (khro:T? ,c))) conds)))

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
