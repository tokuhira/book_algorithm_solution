;; 2 点 (x1, y1) と (x2, y2) との距離を求める関数
(defun calc-dist (x1 y1 x2 y2)
  (sqrt (+ (* (- x1 x2) (- x1 x2)) (* (- y1 y2) (- y1 y2)))))

(defun main ()
  ;; 入力データを受け取る
  (let ((N) (x)	(y))
    (setf N (read))
    (setf x (make-array N))
    (setf y (make-array N))
    (loop for i below N
       do (setf (aref x i) (read))
	  (setf (aref y i) (read)))

    ;; 求める値を、十分大きい値で初期化しておく
    (let ((minimum_dist 100000000.0))

      ;; 探索開始
      (loop for i below N
	 do (loop for j from (+ i 1) below N
	       do (let ((dist_i_j
			 (calc-dist
			  (aref x i) (aref y i)
			  (aref x j) (aref y j))))
		    (if (< dist_i_j minimum_dist)
			(setf minimum_dist dist_i_j)))))

      ;; 答えを出力する
      (princ minimum_dist)
      (terpri))))

(main)
