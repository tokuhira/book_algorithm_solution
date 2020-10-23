(defun main ()
  (let ((N) (W) (weight) (value))
    ;; 入力受け取り
    (setf N (read))
    (setf W (read))
    (setf weight (make-array N))
    (setf value (make-array N))
    (loop for i below N
       do (progn (setf (aref weight i) (read))
		 (setf (aref value i) (read))))

    ;; DP テーブル定義
    (let ((dp (make-array (list (1+ N) (1+ W)) :initial-element 0)))

      ;; DPループ
      (loop for i below N
	 do (loop for w to W
	       do (setf (aref dp (1+ i) w)
			(max
			 
			 ;; i 番目の品物を選ぶ場合
			 (if (>= (- w (aref weight i)) 0)
			     (+ (aref dp i (- w (aref weight i)))
				(aref value i))
			     0)

			 ;; i 番目の品物を選ばない場合
			 (aref dp i w)))))

      ;; 最適値の出力
      (princ (aref dp N W))
      (terpri))))

(main)
