;; 無限大を表す値
(defconstant +INF+ (ash 1 60))

(defun main ()
  ;; 頂点数，辺数
  (let ((N (read))
	(M (read))
	(dp))

    ;; dp 配列 (INF で初期化します)
    (setf dp (make-array (list N N) :initial-element +INF+))

    ;; dp 初期条件
    (loop for e below M
       do (let ((a (read))
		(b (read))
		(w (read)))
	    (setf (aref dp a b) w)))
    (loop for v below N
       do (setf (aref dp v v) 0))

    ;; dp 遷移 (フロイド・ワーシャル法)
    (loop for k below N
       do (loop for i below N
	     do (loop for j below N
		   do (setf (aref dp i j)
			    (min (aref dp i j)
				 (+ (aref dp i k)
				    (aref dp k j)))))))

    ;; 結果出力
    ;; もし dp[v][v] < 0 なら負閉路が存在する
    (let ((exist_negative_cycle nil))
      (loop for v below N
	 if (< (aref dp v v) 0)
	 do (setf exist_negative_cycle t))
      (if exist_negative_cycle
	  (format t "NEGATIVE CYCLE~%")
	  (loop for i below N
	     do (loop for j below N
		   if (/= j 0) do (princ " ")
		   if (< (aref dp i j) (/ +INF+ 2)) do (princ (aref dp i j))
		   else do (princ "INF"))
		(terpri))))))

(main)
