;;;; package.lisp

(defpackage #:read-memory/mock
  (:use #:cl #:cl-who #:hunchentoot #:parenscript #:drakma #:jfh-web)
  (:export :define-ps-with-html-macro :define-my-ps-macro))

(defpackage #:read-memory
  (:use #:cl #:cl-who #:hunchentoot #:parenscript #:jfh-web #:read-memory/mock))
