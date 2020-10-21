(defun main ()
  (let ((N (read))
	(count 0))
    (loop for i below N
       do (loop for j below N
	     do (incf count)))))

(main)
