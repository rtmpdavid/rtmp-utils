(in-package #:rtmp-utils)

(defun make-eq (datum &optional &key (pred #'eq) (key nil key-p))
  "Makes a comparsion predicate lambda
datum - a thing the lambda will compare to (first arg is datum, second is the lambda arg)
pred - a function it will use for comparsion
key - a function that will be applied to the argument before comparsion"
  (if (not (or (functionp pred) (symbolp pred)))
      (error "Pred must be a function or a symbol"))
  (if (not (or (functionp key) (symbolp key)))
      (error "Key must be a function or a symbol"))
  (if key-p
      (lambda (a)
        (funcall pred datum (funcall key a)))
      (lambda (a)
        (funcall pred datum a))))
