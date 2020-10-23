(defun main ()
  (let ((INF) (N) (h))
    (setf INF (ash 1 60)) ;; 十分大きい値とする (ここでは 2^60)
    
    ;; 入力
    (setf N (read))
    (setf h (make-array N))
    (loop for i below N
	  do (setf (aref h i) (read)))

    ;; 配列 dp を定義 (配列全体を無限大を表す値に初期化)
    (let ((dp (make-array N :initial-element INF)))

      ;; 初期条件
      (setf (aref dp 0) 0)

      ;; ループ
      (loop for i below N
	    if (< (+ i 1) N)
	      do (setf (aref dp (+ i 1))
		       (min (aref dp (+ i 1))
			    (+ (aref dp i)
			       (abs (- (aref h i) (aref h (+ i 1)))))))
	    if (< (+ i 2) N)
	      do (setf (aref dp (+ i 2))
		       (min (aref dp (+ i 2))
			    (+ (aref dp i)
			       (abs (- (aref h i) (aref h (+ i 2))))))))

      ;; 答え
      (princ (aref dp (- N 1)))
      (terpri))))

(main)
