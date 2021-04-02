(in-package :cl-units)

(defclass scale ()
  ((name :type symbol :reader scale-name)
   (sym :type symbol :reader scale-symbol)
   (mult :type number :initarg :multiplier :accessor scale-multiplier)))

(defmacro defscale (name-val sym-val mult-val)
  `(defclass ,name-val (scale)
     ((name :initform ',name-val)
      (sym :initform ',sym-val)
      (mult :initform ,mult-val))))
       
(defscale kilo K 1000)
(defscale centi c 0.01)
      
(defclass base-unit-type ()
  ((name :type string :reader unit-name)
   (unit-type :type symbol :reader unit-type)
   (base-sym :type symbol :accessor base-symbol)
   (scale :type scale :initarg :scale :accessor measure-scale))
  (:default-initargs
   :scale nil))

(defmacro defbaseunit (name)
  (let ((name-symbol (intern (concatenate 'string (string name) "-BASE-UNIT"))))
    `(defclass ,name-symbol (base-unit-type)
       ((unit-type :initform ',name)))))
       
(defbaseunit distance)
(defbaseunit scalar)
(defbaseunit mass)
(defbaseunit time)

(defmacro defunit (name sym-val base-name)
  (let ((base-name-symbol (intern (concatenate 'string (string base-name) "-BASE-UNIT"))))
    `(defclass ,name (,base-name-symbol)
       ((name :initform ',name)
	(sym :initform ',sym-val)))))
        
(defunit meter m distance)
(defunit unit-second s time)       

(defclass measure-type ()
  ((top-units :initarg :top :reader top-units)
   (bottom-units :initarg :bottom :reader bottom-units)
   (value :initarg :value :reader measure-value)
   (base-sym :type symbol :reader base-symbol)))

(defmacro defmeasure (name top-base-units bottom-base-units)
  (let ((class-symbol (intern (concatenate 'string (string name) "-MEASURE")))
	(make-func (intern (concatenate 'string "MAKE-" (string name) "-MEASURE"))))
    `(progn
       (defclass ,class-symbol (measure-type)
       	 ((base-sym :initform ',name)))
       (defun ,make-func (value)
       	 (make-instance ',class-symbol :top ,top-base-units :bottom ,bottom-base-units :value value)))))

(defmeasure length (list 'distance) '())

  
;; (defclass distance-measure (measure-type)
;;   ((base-sym :initform 'distance)))

;; (defmethod make-distance-measure (value (distance distance-base-unit))
;;   (make-instance 'distance-unit :top (list distance) :bottom '() :value value))

;; (defclass speed-unit (unit-type)
;;   ((base-sym :initform 'distance/time)))
  
;; (defmethod make-speed-unit (value (distance distance-base-unit) (time time-base-unit))
;;   (make-instance 'speed-unit :top (list distance) :bottom (list time) :value value))

  
