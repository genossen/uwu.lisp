# uwu.lisp

## Step 1

```common-lisp
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
```

```
~$ sbcl
```

```common-lisp
* (load "uwu.lisp")
* (pet-idle-movement +pet-gfx-neko+)
```

## Step 2

Set up some simple data structures. A lot of this is adapted from the
famed land of lisp educational book.

`*objects*` holds all the objects in the game, and `*inventory*` holds
 all the objects that the player has.

```common-lisp
(defparameter *objects* '(OBJECT))

(defparameter *inventory* '(OBJECT))
```

```common-lisp
(defun pickup (object)
  (cond ((member object *objects*)
         (push (list object) *inventory*)
         `(you are now carrying the ,object))
	  (t `(you cannot get the ,object))))
```

```common-lisp
(defun inventory ()
  (cons 'items- *inventory*))

(defun have (object) 
    (member object (cdr (inventory))))
```

```common-lisp
;;; now the REPLy bits...

(defun game-repl ()
    (let ((cmd (game-read)))
        (unless (eq (car cmd) 'quit)
            (game-print (game-eval cmd))
            (game-repl))))

(defun game-read ()
    (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
         (flet ((quote-it (x)
                    (list 'quote x)))
             (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defparameter *allowed-commands* '(look pickup inventory))

(defun game-eval (sexp)
    (if (member (car sexp) *allowed-commands*)
        (eval sexp)
        '(i do not know that command.)))
```
