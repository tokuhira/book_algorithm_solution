(defconstant +INF+ (ash 1 60)) ;; 十分大きな値 (ここでは 2^60)

(defun main ()
  (let ((N) (c))
    
    ;; 入力
    (setf N (read))
    (setf c (make-array (list (1+ N)
			      (1+ N))))
    (loop for i to N
       do (loop for j to N
             do (setf (aref c i j) (read))))


    ;; DP テーブル定義
    (let ((dp (make-array (1+ N) :initial-element +INF+)))

      ;; DP 初期条件
      (setf (aref dp 0) 0)

      ;; DPループ
      (loop for i to N
	 do (loop for j below i
	       if (> (aref dp i)
		     (+ (aref dp j) (aref c j i)))
	       do (setf (aref dp i)
			(+ (aref dp j) (aref c j i)))))

      ;; スコア表と DP テーブル確認
      ;(print c *error-output*)
      ;(print dp *error-output*)
      ;(terpri *error-output*)

      ;; 最適値の出力
      (princ (aref dp N))
      (terpri))))

(main)
