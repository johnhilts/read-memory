(in-package #:read-memory)

(defun get-top-stories (story-count)
  "get the top N stories"
  (subseq (read-memory/mock::get-mock-json "top-stories.json") 0 story-count))

(defun get-story (story-id)
  "get story details"
  (read-memory/mock::get-mock-json "story.json"))

(defun get-comment (comment-id)
  "get comment details"
  (read-memory/mock::get-mock-json "comment.json"))

(defun get-kids (item)
  "get child IDs"
  (subseq (find-if #'(lambda (e) (equal :kids (car e))) item) 1))
