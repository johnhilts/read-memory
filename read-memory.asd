;;;; read-memory.asd

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(push #p"/home/jfh/code/lisp/source/util-lib/web/jfh-web/" asdf:*central-registry*)
(push #p"/home/jfh/code/lisp/source/web/todo/todo-project/" asdf:*central-registry*)
(asdf:load-system "jfh-web")
(compile-file #p"/home/jfh/code/lisp/source/util-lib/web/jfh-web/jfh-web.lisp")

(asdf:defsystem #:read-memory
  :description "Keep track of what you've already read online."
  :author "John Hilts <johnhilts@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-who #:hunchentoot #:parenscript #:cl-json #:jfh-web)
  :components ((:file "package")
               (:file "main")))

(defun buildapp ()
  (asdf:load-system :read-memory)
  (save-lisp-and-die "read-memory-app"
                     :toplevel 'cl-user::main
                     :executable t))
