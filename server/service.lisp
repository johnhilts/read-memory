(in-package #:read-memory)

(defun get-post-list (&key count for)
  "get the main list of stories, articles, etc"
  (case for
    (:hn
     (get-top-stories count))))

(defun get-list-item-by-id (item-id &key for type)
  "get an item by its ID"
  (case for
    (:hn
     (case type
       (:post (get-story item-id))
       (:comment (get-comment item-id))))))

(defun get-sub-item (item &key key for)
  "get a sub-item by a key"
  (case for
    (:hn
     (cdr (find-if #'(lambda (e) (equal key (car e))) item)))))

(defun get-comments (parent-item &key for)
  "get the comments associated with a parent item"
  (case for
    (:hn
     (get-kids parent-item))))
  
(defun get-kids (item)
  "get child IDs"
  (subseq (find-if #'(lambda (e) (equal :kids (car e))) item) 1))
