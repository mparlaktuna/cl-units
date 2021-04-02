(in-package :cl-units)

(defclass scale ()
  ((name :type string :reader scale-name)
   (sym :type string :reader scale-symbol)
   (mult :type integer :initarg :multiplier :accessor scale-multiplier)))

(defclass kilo (scale)
  ((name :initform "kilo")
   (sym :initform "K")
   (mult :initform 1000)))

(defclass base-unit-type ()
  ((name :type string :reader unit-name)
   (unit-type :type symbol :reader unit-type)
   (value :type number :reader unit-value :initarg :value)
   (scale :type scale :initarg :scale :accessor unit-scale)
   (base-sym :type symbol :accessor base-symbol))
  (:default-initargs
   :value 1
   :scale nil))
   
(defclass distance-base-unit (base-unit-type)
  ((unit-type :initform 'distance)))
(defclass scalar-base-unit (base-unit-type)
  ((unit-type :initform 'scalar)))
(defclass mass-base-unit (base-unit-type)
  ((unit-type :initform 'mass)))
(defclass time-base-unit (base-unit-type)
  ((unit-type :initform 'time)))

(defclass meter (distance-base-unit)
  ((name :initform 'meter)
   (sym :initform 'm)))

(defclass unit-second (time-base-unit)
  ((name :initform 'second)
   (sym :initform 's)))

(defclass measure-type ()
  ((top-units :initarg :top :reader top-units)
   (bottom-units :initarg :bottom :reader bottom-units)
   (value :initarg :value :reader unit-value)
   (base-sym :type symbol :reader base-symbol)))

(defclass distance-measure (measure-type)
  ((base-sym :initform 'distance)))

(defmethod make-distance-measure (value (distance distance-base-unit))
  (make-instance 'distance-unit :top (list distance) :bottom '() :value value))

(defclass speed-unit (unit-type)
  ())
  
(defmethod make-speed-unit (value (distance distance-base-unit) (time time-base-unit))
  (make-instance 'speed-unit :top (list distance) :bottom (list time) :value value))

  
