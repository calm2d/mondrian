(in-package #:calm)

(setf *calm-width* 600)
(setf *calm-height* 500)
(setf *calm-title* "Mondrian")

(defun on-mousebuttonup (&key button x y clicks)
  (declare (ignore button x y clicks))
  (setf *calm-redraw* t))

;; white, red, yellow, blue
(defparameter *mondrian-color-list* '((0.93 0.92 0.94) (0.89 0.12 0.17) (0.94 0.87 0.47) (0 0.35 0.59)))

(defun draw-rect (x y w h &optional color)
  (c:set-source-rgb 0 0 0)
  (c:rectangle x y w h)
  (c:stroke-preserve)
  (apply #'c:set-source-rgb (nth (if color (1+ (random 3)) 0) *mondrian-color-list*))
  (c:fill-path))

(defun draw ()
  (c:set-line-width 20)
  (loop with x = 0
        for width = (+ 42 (random 300))
        until (> x *calm-width*)
        do (loop with y = 0
                 for height = (+ 42 (random 300))
                 until (> y *calm-height*)
                 do (draw-rect x y width height (= (random 3) 0))
                 do (incf y height))
        do (incf x width))
  (setf *calm-redraw* nil))
