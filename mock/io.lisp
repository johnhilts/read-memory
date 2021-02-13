(in-package #:read-memory/mock)

(defun read-mock-file (filename)
  (with-output-to-string (out)
    (with-open-file (in (concatenate 'string "mock/" filename))
      (loop with buffer = (make-array 8192 :element-type 'character)
         for n-characters = (read-sequence buffer in)
         while (< 0 n-characters)
         do (write-sequence buffer out :start 0 :end n-characters)))))

(defun get-mock-json (filename)
  (json:decode-json-from-string (read-mock-file filename)))

(defun get-kids (item)
  (subseq (find-if #'(lambda (e) (equal :kids (car e))) item) 1))

(defun get-comment-text (item)
  (cdr (find-if #'(lambda (e) (equal :text (car e))) item)))

(defun get-comment (item key)
  (cdr (find-if #'(lambda (e) (equal key (car e))) item)))

(defun add-new-kids (kids)
  (append (list 1234 5678 9012) kids))

(defun test-filter-new-only ()
  (let* ((old (get-kids (get-mock-json "story.json")))
         (new (add-new-kids old)))
    (set-difference new old)))

;; Examples
;; (get-mock-json "story.json")
;; (get-mock-json "top-stories.json")
;; (find-if #'(lambda (e) (equal :kids (car e))) (get-mock-json "story.json"))
