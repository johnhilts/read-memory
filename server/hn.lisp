(in-package #:read-memory)

(defun get-top-stories (story-count)
  "get the top N stories"
  (subseq (get-mock-json "top-stories.json") 0 story-count))

(defun get-story (story-id)
  "get story details"
  (get-mock-json "story.json"))

(defun get-kids (item)
  "get child IDs"
  (subseq (find-if #'(lambda (e) (equal :kids (car e))) item) 1))
