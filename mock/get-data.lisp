(in-package #:read-memory/mock)

(defun get-data-to-mock (story-id &key data-type)
  (case data-type
    (:story
     (let* ((url
             (concatenate
              'string
              "https://hacker-news.firebaseio.com/v0/item/"
              (write-to-string story-id)
              ".json"))
            (json (read-from-string (format nil "~a" (drakma:http-request url)))))
       (cl-json:decode-json-from-string 
        (do 
         ((i 0 (incf i))
          (str ""))
         ((>= i (length json)) str)
          (setf str
                (concatenate
                 'string
                 str
                 (string (code-char (aref json i)))))))))))


(defun write-complete-file-by-line (path list)
  "write complete file one line at a time"
  (with-open-file (out path :direction :output :if-exists :supersede :if-does-not-exist :create)
    (dolist (line list)
      (print line out))))

;; save-location: "/home/jfh/code/lisp/source/web/read-memory/test-request.json"
(defun get-and-save-mock-data (save-location)
  "loop through list of story IDs, fetch matching json and save it to a file"
  (dolist (story-id (subseq (read-memory/mock::get-mock-json "top-stories.json") 0 20))
    (let ((save-file-name
           (concatenate
            'string
            save-location
            (write-to-string story-id))))
      (write-complete-file-by-line
       save-file-name
       (read-memory/mock::get-data-to-mock story-id :data-type :story)))))
      
