(defconstant +pet-gfx-neko+
  (list
   '(gfx
      "(*Φ ω Φ*)" ;; forward
      "(*Φ ω Φ* )" ;; left-facing
      "( *Φ ω Φ*)" ;; right-facing
      "(∿*Φ ω Φ*)∿" ;; right-moving
      "∿(*Φ ω Φ*∿)");; left-moving
   '(name "neko")))

(defvar *movement* 0)

(defun pet-idle-movement (pet-gfx)
  (let ((rng-move (random 5)))
    (cond
      ((and
	    (= 3 rng-move)
	    (> *movement* 0))
       (decf *movement*))

      ((and
	(= 4 rng-move)
	(< *movement* 9))
       (incf *movement*)))

    (princ
     (concatenate 'string
      (subseq "          " *movement*)
      (nth rng-move (cdar pet-gfx))))))


