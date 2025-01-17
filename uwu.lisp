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

(defvar *spicy-food-name* "SPICY")
(defvar *sour-food-name* "SOUR")
(defvar *salty-food-name* "SALTY")
(defvar *sweet-food-name* "SWEET")
(defvar *savoury-food-name* "SAVOURY")

(defvar *spicy-food* 0)
(defvar *sour-food* 0)
(defvar *salty-food* 0)
(defvar *sweet-food* 0)
(defvar *savoury-food* 0)

(defvar *uwu-points* 100)

(defun pet-shop-menu-food ()
  (loop do
    
    (princ "This is the food ~") (terpri)
    (sleep 1)
    (princ "Options: > ") (princ *spicy-food-name*) (terpri)
    (princ "         > ") (princ *sour-food-name*) (terpri)
    (princ "         > ") (princ *salty-food-name*) (terpri)
    (princ "         > ") (princ *sweet-food-name*) (terpri)
    (princ "         > ") (princ *savoury-food-name*) (terpri)
    (princ "         > EXIT") (terpri)
    (sleep 1)
    (princ "> ")

    (let ((input (read)))
      (cond ((eq input 'SPICY) (print "spicy"))
	    ((eq input 'SOUR) (print "sour"))
	    ((eq input 'SALTY) (print "salty"))
	    ((eq input 'SWEET) (print "sweet"))
            ((eq input 'SAVOURY) (print "savoury"))
	    ((eq input 'EXIT) (return))))))

(defun pet-game-rng-binary ()
  (let ((rng (random 2))
	(user-choice (read)))
    (cond
      ((and
	(= rng 0)
	(eq user-choice 'Z))
       'win)
      ((and
	(= rng 1)
	(eq user-choice 'A))
       'win)
      (t 'lose))))

(defun pet-game-up-down ()
  (sleep 1)
  (princ "Let's play a game!") (terpri)
  (sleep 1)
  (princ "Up or down!") (terpri)
  (sleep 1)
  (terpri)
  (princ "Make a choice!") (terpri)
  (sleep 1)
  (princ "[A] Up, or [Z] Down??") (terpri)
  (sleep 1)
  (terpri)
  (princ "> ")
  (cond
    ((eq (pet-game-rng-binary) 'win)
     (sleep 1)
     (princ "You win!") (terpri)
     (sleep 1)
     (incf *uwu-points*)
     (princ "Your points: ") (princ *uwu-points*))
    (t
     (sleep 1)
     (princ "Oh no!! Not a match! Try again??"))))
