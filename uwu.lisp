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

(defun pet-shop ()
  (loop do
    (princ "This is the shop.") (terpri)
    (sleep 1)
    (princ "Options: > FOOD") (terpri)
    (princ "         > MEDICINE") (terpri)
    (princ "         > GROWTH") (terpri)
    (princ "         > CHANGE") (terpri)
    (princ "         > EXIT") (terpri)
    (sleep 1)
    (princ "> ")

    (when
	(eq (read) 'EXIT) (return))

    (when
	(eq (read) 'FOOD) (pet-shop-menu-food))))

(defvar *spicy-food* "SPICY food.")
(defvar *sour-food* "SOUR food.")
(defvar *salty-food* "SALTY food.")
(defvar *sweet-food* "SWEET food.")
(defvar *savoury-food* "SAVOURY food.")

(defun pet-shop-menu-food ()
  (loop do
    
    (princ "This is the food ~") (terpri)
    (sleep 1)
    (princ "Options: > ") (princ *spicy-food*) (terpri)
    (princ "         > ") (princ *sour-food*) (terpri)
    (princ "         > ") (princ *salty-food*) (terpri)
    (princ "         > ") (princ *sweet-food*) (terpri)
    (princ "         > ") (princ *savoury-food*) (terpri)
    (sleep 1)
    (princ "> ")

    (let ((input (read)))
      (cond ((eq input 'SPICY) (print "spicy"))
	    ((eq input 'SOUR) (print "sour"))
	    ((eq input 'SALTY) (print "salty"))
	    ((eq input 'SWEET) (print "sweet"))
            ((eq input 'SAVOURY) (print "savoury"))
	    ((eq input 'EXIT) (return))))))
