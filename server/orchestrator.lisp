(in-package #:read-memory)

(defun get-posts-for-display (&key for is-refresh)
  "if no old posts, always get new posts, no processing needed
  if old posts and (not is-refresh), only return old posts
  if old posts, and is-refresh, get old and new and flag which is which
  so, always get old posts no matter what - they're \"cached\" anyway, so it's a cheap fetch!"
  (flet ((flag (old-post-list new-post-list)
           "distinguish old posts from new ones"
           (append
            (get-post-list-with-details new-post-list :for for :age-level :new)
            (get-post-list-with-details old-post-list :for for :age-level :old))))
    (let ((old-post-list (get-old-post-list :for for)))
      (cond
        ((zerop (length old-post-list))
         (flag (get-all-posts-from-source :for for) ()))
        ((equal is-refresh :true)
         (let* ((all-post-list (get-all-posts-from-source :for for))
                (new-post-list (set-difference all-post-list old-post-list)))
           (flag old-post-list new-post-list)))
        (t (flag old-post-list ()))))))

(defun get-comments-for-display (&key for)
  )
