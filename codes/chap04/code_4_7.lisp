(defun main ()
  (let ((F (make-array 50)))
    (setf (aref F 0) 0)
    (setf (aref F 1) 1)
    (loop for N from 2 below 50
	  do (progn (setf (aref F N) (+ (aref F (- N 1))
					(aref F (- N 2))))
		    (format t "~S 項目: ~S~%" N (aref F N))))))
							    
(main)
