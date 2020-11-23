(defun main()
  (let ((N) (A) (B))
    ;; 入力
    (setf N (read))
    (setf A (make-array N))
    (setf B (make-array N))
    (loop for i below N
       do (setf (aref A i) (read))
	  (setf (aref B i) (read)))

    ;; 答え
    (let ((sum 0))
      (loop for i from (1- N) downto 0
	 do (let ((amari) (D 0))
	      (setf (aref A i) (+ (aref A i) sum))
	      (setf amari (mod (aref A i) (aref B i)))
	      (if (/= amari 0)
		  (setf D (- (aref B i) amari)))
	      (setf sum (+ sum D))))
      (princ sum)
      (terpri))))

(main)
