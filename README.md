# uwu.lisp

## Step 1

```bash
$ git clone https://git.sr.ht/~vidak/uwu.el
```

```bash
$ cd uwu.el
```

```bash
$ cd version-3/mvc/
```

see file `view.el`:

```elisp
(defun pet-idle-movement (pet-gfx)

  (let ((rng-move (random 5))) 

    (cond ((and 
	    (= 3 rng-move)
	    (> *movement* 0))
	   (decf *movement*))

	  ((and
	    (= 4 rng-move)
	    (< *movement* 9))

	   (incf *movement*)))

    (princ (symbol-value (nth 1 (assoc *toilet* +toilet-list+)))
	   (get-buffer-create "*uwu*"))

    (princ "╔═════════════════════╗" (get-buffer-create "*uwu*"))
    (terpri (get-buffer-create "*uwu*"))
    
    (princ
     (concat 
      (substring "          " *movement*) 

      (nth
       rng-move
       (cdr pet-gfx)))
     (get-buffer-create "*uwu*"))

    (terpri (get-buffer-create "*uwu*"))
	
	(princ "╚═════════════════════╝" (get-buffer-create "*uwu*"))

    (terpri (get-buffer-create "*uwu*"))

    (princ (symbol-value (nth 1 (assoc *hearts* +heart-list+)))
	   (get-buffer-create "*uwu*"))))
```

strip it down to the bare essentials:

```elisp 
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
     (concat 
      (substring "          " *movement*)
      (nth rng-move (cdr pet-gfx)))
     (get-buffer-create "*uwu*"))))
```

see `gfx/chaotic/pack-0.el`:

```elisp
(defconst +adult-chaotic-3+
  (list
   '(gfx
      "(*Φ ω Φ*)" ;; forward
      "(*Φ ω Φ* )" ;; left-facing
      "( *Φ ω Φ*)" ;; right-facing
      "(∿*Φ ω Φ*)∿" ;; right-moving
      "∿(*Φ ω Φ*∿)");; left-moving
   '(name "neko")))
```

```elisp
ELISP> (pet-idle-movement +adult-chaotic+)
```

## Step 2

```common-lisp
(defparameter *nodes* '((LOCATION (DESCRIPTION))))

(defparameter *edges* '((LOCATION (OTHER-LOCATION METHOD))))

(defparameter *objects* '(OBJECT))

(defparameter *inventory* '(OBJECT))

(defun describe-objects (loc objs obj-loc)
   (labels ((describe-obj (obj)
                `(you see a ,obj on the floor.)))
      (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))
	  
;;; simplify, because we don't care about going into different rooms:

(defun look (objs)
   (labels ((describe-obj (obj)
                `(you see a ,obj .)))
     (apply #'append (mapcar #'describe-obj objs))))

(defun pickup (object)
  (cond (TEST)
         (push (list object 'body) *object-locations*)
         `(you are now carrying the ,object))
	  (t `(you cannot get the ,object))))

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
