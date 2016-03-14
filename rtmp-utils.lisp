(in-package #:rtmp-utils)

(defun make-pred (datum &optional (pred #'eq) (key nil key-p))
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

(defmacro string-case (keystring &body cases)
  "like case, but with strings"
  `(cond ,@(loop for case in cases
	      collecting
		(if (cdr case) (list `(string= ,keystring ,(car case))
				     (cadr case))
		    (list 't (car case))))))

(defmacro hash-memoize (key hash-table &body body)
    "get a value from the hash table or set it to the
     result of body if key isn't present"
    (alexandria:with-gensyms (val present)
      `(multiple-value-bind (,val ,present)
	   (gethash ,key ,hash-table)
	 (if ,present ,val
	     (setf (gethash ,key ,hash-table)
		   ,@body)))))
