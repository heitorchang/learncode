(defun rng (max)
  (let ((v (make-array max)))
    (dotimes (i max)
      (setf (aref v i) (+ 1 i)))
    v))

(defun ts (max)
  (make-array max :initial-element 0))

(defun nextptr (i s d)
  (dotimes (j s)
    (if (> (aref d (mod (+ i j 1) s)) 0)
        (progn
          (dotimes (k s)
            (if (> (aref d (mod (+ i j k 2) s)) 0)
                (return-from nextptr (mod (+ i j k 2) s))))))))


(defun findwinner (s d)
  (let ((found 0))
    (dotimes (i s)
      (if (> (aref d i) 0)
          (setf found (aref d i))))
    found))

(defun pjCircle (s w)
  (let ((ptr 1)
        (st (rng s))
        (ans (ts s)))
    (dotimes (i (- s 1))
      (setf (aref ans i) (aref st ptr))
      (setf (aref st ptr) 0)
      (setf ptr (nextptr ptr s st)))
    (setf (aref ans (- s 1)) (findwinner s st))
    (subseq ans (- s w) s)))
