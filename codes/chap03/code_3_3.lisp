(defun main ()
  (let ((N) (a)
	(INF 20000000)) ;; 十分大きな値に

    ;; 入力を受け取る
    (setf N (read))
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; 線形探索
    (let ((min_value INF))
      (loop for i below N
	 when (< (aref a i) min_value)
	 do (setf min_value (aref a i)))

      ;; 結果出力
      (princ min_value)
      (terpri))))

(main)
