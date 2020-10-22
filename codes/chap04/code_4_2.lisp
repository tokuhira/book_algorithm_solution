(defun func (N)
  (format t "func(~S)を呼び出しました~%" N)
  (if (= N 0)
      0
      (let ((result (+ N (func (- N 1)))))
	(format t "~S までの和 = ~S~%" N result)
	result)))

(func 5)
