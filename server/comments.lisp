(in-package #:read-memory)

(defun build-comment-item (item-id &key for)
  "get details of each comment"
  (let ((item (get-list-item-by-id item-id :for for :type :comment)))
    (list
     (cons :id (get-sub-item item :key :id :for 'hn))
     (cons :by (get-sub-item item :key :by :for 'hn))
     (cons :text (get-sub-item item :key :text :for 'hn))
     (cons :comments (get-sub-item item :key :kids :for 'hn)))))

(defun get-comments-for-post (item &key for)
  "get lis of comments with all their details"
  (let ((comment-list (get-comments item :for for))
        (comment-item-list))
    ;; todo - recurse through each comment's descendants - also keep track of level
    (dolist (item-id comment-list)
      (push (build-comment-item item-id :for for) comment-item-list))
    comment-item-list))
