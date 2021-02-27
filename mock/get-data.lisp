(in-package #:read-memory/mock)

(defun get-data-to-mock (story-id &key data-type)
  (case data-type
    (:story
     (let* ((url (concatenate 'string
                              "https://hacker-news.firebaseio.com/v0/item/"
                              (write-to-string story-id)
                              ".json"))
            (json (read-from-string (format nil "~a" (drakma:http-request url)))))
       (cl-json:decode-json-from-string 
        (do 
         ((i 0 (incf i))
          (str ""))
         ((>= i (length json)) str)
          (setf str (concatenate 'string str (string (code-char (aref json i)))))))))))

