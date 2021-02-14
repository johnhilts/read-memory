(in-package #:read-memory)

(defun build-post-item (item-id &key for)
  "populate each post's details"
  (let ((item (get-list-item-by-id item-id :for for :type :post)))
    (list
     (cons :id (get-sub-item item :key :id :for :hn))
     (cons :by (get-sub-item item :key :by :for :hn))
     (cons :title (get-sub-item item :key :title :for :hn))
     (cons :url (get-sub-item item :key :url :for :hn))
     (cons :comments (get-sub-item item :key :kids :for :hn))
     (cons :comment-count (get-sub-item item :key :descendants :for :hn)))))

(defun get-post-list-with-details (&key for)
  "get list of posts with all their details"
  (let ((post-list (get-post-list :count 20 :for for))
        (post-item-list))
    (dolist (item-id post-list)
      (push (build-post-item item-id :for for) post-item-list))
    post-item-list))

(defun build-comment-item (item-id &key for)
  "get details of each comment"
  (let ((item (get-list-item-by-id item-id :for for :type :comment)))
    (list
     (cons :id (get-sub-item item :key :id :for :hn))
     (cons :by (get-sub-item item :key :by :for :hn))
     (cons :text (get-sub-item item :key :text :for :hn))
     (cons :comments (get-sub-item item :key :kids :for :hn)))))

(defun get-comments-for-post (item &key for)
  "get lis of comments with all their details"
  (let ((comment-list (get-comments item :for for))
        (comment-item-list))
    ;; todo - recurse through each comment's descendants - also keep track of level
    (dolist (item-id comment-list)
      (push (build-comment-item item-id :for for) comment-item-list))
    comment-item-list))
