(in-package #:read-memory)

(defun build-post-item (item-id &key for age-level)
  "populate each post's details"
  (let ((item (get-list-item-by-id item-id :for for :type :post)))
    (list
     (cons :id (get-sub-item item :key :id :for :hn))
     (cons :age-level age-level)
     (cons :by (get-sub-item item :key :by :for :hn))
     (cons :title (get-sub-item item :key :title :for :hn))
     (cons :url (get-sub-item item :key :url :for :hn))
     (cons :comments (get-sub-item item :key :kids :for :hn))
     (cons :comment-count (get-sub-item item :key :descendants :for :hn)))))

(defun get-post-list-with-details (post-list &key for age-level)
  "get list of posts with all their details"
  (let ((post-item-list))
    (dolist (item-id post-list)
      (push (build-post-item item-id :for for :age-level age-level) post-item-list))
    post-item-list))

(defun get-all-posts-from-source (&key for)
   (get-post-list :count 20 :for for))

(defun get-old-post-list (&key for)
   (get-post-list :count 20 :for for)) ; need to create a function to get old posts from "cache"
