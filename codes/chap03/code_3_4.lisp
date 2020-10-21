(defun main ()
  (let ((N) (K) (a) (b)
	(INF 20000000)) ;; 十分大きな値に

    ;; 入力を受け取る
    (setf N (read))
    (setf K (read))
    (setf a (make-array N))
    (setf b (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))
    (loop for i below N
       do (setf (aref b i) (read)))

    ;; 線形探索
    (let ((min_value INF))
      (loop for i below N
	 do (loop for j below N
	       do (let ((a+b (+ (aref a i)
				(aref b j))))
		    (if (and (<= K a+b)
			     (< a+b min_value))
			(setf min_value a+b)))))

      ;; 結果出力
      (princ min_value)
      (terpri))))

(main)
