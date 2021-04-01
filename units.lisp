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
   (scale :type scale :initarg nil :accessor unit-scale)))

(defclass length-unit-type (unit-type) ())

(defclass mass-unit-type (unit-type) ())

(defclass time-unit-type (unit-type) ())

(defmacro make-unit-type (&keys top bottom name)
  `(defclass ,name (unit-type)
    ((top :initarg ,top :accessor unit-top-type)
     (bottom :initarg ,bottom :accessor unit-bottom-tyop))))
  
(defmacro make-unit (unit-type name symbol)
  `(defclass ,name (,unit-type)
    ((name :initform (string ,name))
     (sym :initform (string ,symbol)))))

(make-unit length-unit-type meter m)     
;; (defclass meter (length-unit)
;;   ((name :initform "meter")
;;    (sym :initform "m")))

;; (defclass gram (mass-unit)
;;   ((name :initform "gram")
;;    (sym :initform "g")))

;; (defclass time-second (time-unit)
;;   ((name :initform "second")
;;    (sym :initform "s")))

;; (defclass unit ()
;;   ((value :initarg :value :accessor unit-value)
;;    (top :reader unit-top)
;;    (bottom :reader unit-bottom)))

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
