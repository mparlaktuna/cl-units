(defclass scale ()
  ((name :type string :reader scale-name)
   (sym :type string :reader scale-symbol)
   (mult :type integer :initarg :multiplier :accessor scale-multiplier)))

(defclass kilo (scale)
  ((name :initform "kilo")
   (sym :initform "K")
   (mult :initform 1000)))

(defclass unit-type ()
  ((name :type string :reader unit-name)
   (sym :type string :reader unit-symbol)
   (scale :type scale :initarg :scale :accessor unit-scale)))

(defmacro make-unit-type (&keys name top bottom)
  `(defclass ,name (unit-type)
    ((top :initarg ,top :accessor unit-top-type)
     (bottom :initarg ,bottom :accessor unit-bottom-tyop))))

(defmacro make-unit (unit-type name symbol)
  (let ((unit-name (string name))
	(unit-symbol (string symbol)))
    `(defclass ,name (,unit-type)
       ((value :initarg :value :accessor unit-value )
	(name :initform ,unit-name)
	(sym :initform ,unit-symbol))
       (:default-initargs
	:value 1
        :scale nil))))

(defclass length-unit-type (unit-type) ())
(defclass mass-unit-type (unit-type) ())
(defclass time-unit-type (unit-type) ())

(make-unit-type )
(make-unit length-unit-type meter m)
(make-unit mass-unit-type gram g)
(make-unit time-unit-type unit-second s)

(defun make-value-with-unit (value unit &key (scale nil))
  (make-instance unit :value value :scale scale))


(defclass unit ()
  ((value :initarg :value :accessor unit-value)
   (top :reader unit-top)
   (bottom :reader unit-bottom)))

;; (defclass speed-unit (unit)
;;   ((top :type length-unit :initarg :top)
;;    (bottom :type time-unit :initarg :bottom)))

;; (defmethod make-speed (value (length length-unit) (time time-unit))
;;   (make-instance 'speed-unit :value value :top (list length) :bottom (list time)))   
  
;; (defun unit* (&rest units)
;;   (iter (for unit in units)
;; 	(collect (unit-name unit))))

;; (defmacro create-unit (value &rest units))  
;; (defclass )

;; mass length time temperature current mole candela
