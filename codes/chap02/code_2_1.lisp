(defun main ()
  (let ((N (read))
	(count 0))
    (loop for i below N
       do (incf count))))

(main)
