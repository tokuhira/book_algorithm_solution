(defun main ()
  (let ((N (read)))
    (loop for i from 2 to N by 2
       do (print i))))

(main)
