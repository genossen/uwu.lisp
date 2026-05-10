(defparameter *hunger* 50)
(defparameter *happiness* 50)
(defparameter *energy* 50)
(defparameter *age* 0)
(defparameter *last-update* (get-universal-time))
(defparameter *birth-time* (get-universal-time))

(defun update-pet ()
  (let* ((now (get-universal-time))
	 (hours-passed (floor (/ (- now *last-update*) 3600))))
    (setf *hunger* (min 100 (+ *hunger* (* 2 hours-passed)))
	  *happiness* (max 0 (- *happiness* (* 1 hours-passed)))
	  *energy* (max 0 (- *energy* (* 1 hours-passed)))
	  *age* (+ *age* hours-passed)
	  *last-update* now)))

(defun main ()
  ;; INITIALISE PET

  ;; READ

  ;; EVALUATE

  ;; PRINT)
