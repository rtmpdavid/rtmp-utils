(asdf:defsystem #:rtmp-utils
  :description "A set of small utility functions I find myself re-implementing again and again."
  :version "0.0.1"
  :author "rtmpdavid"
  :license "WTFPL"
  :serial t
  :components ((:file "package")
               (:file "rtmp-utils" :depends-on ("package"))))
