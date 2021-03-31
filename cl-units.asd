(cl:in-package #:asdf-user)

(require :iterate)

(defsystem :cl-units
  :description ""
  :version "0.0.1"
  :author "Mustafa Parlaktuna <mparlaktuna@gmail.com>"
  :serial t
  :depends-on (:iterate)
  ;; :in-order-to ((test-op (test-op cl-cu2e-test)))
  :components ((:file "package")
	       (:file "units")))
 
;; (defsystem cl-cu2e-test
;;   :depends-on (:cl-cu2e
;;                :prove)
;;   :defsystem-depends-on (:prove-asdf)
;;   :components
;;   ((:test-file "cl-cu2e-test"))
;;   :perform (test-op :after (op c)
;;                     (funcall (intern #.(string :run) :prove) c)))

               
               

