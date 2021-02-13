(in-package #:read-memory)

(defun build-story-item (item-id &key for)
  (let ((item (get-list-item-by-id item-id :for for :type 'story)))
    (list
     (cons :id (get-sub-item item :key :id :for 'hn))
     (cons :by (get-sub-item item :key :by :for 'hn))
     (cons :title (get-sub-item item :key :title :for 'hn))
     (cons :url (get-sub-item item :key :url :for 'hn))
     (cons :comment-count (get-sub-item item :key :descendants :for 'hn)))))

(defun get-main-list-with-details (&key for)
  (let ((main-list (get-main-list :count 20 :for for))
        (main-item-list))
    (dolist (item-id main-list)
      (push (build-story-item item-id :for for) main-item-list))
    main-item-list))
