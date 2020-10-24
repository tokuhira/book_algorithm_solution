(defconstant +INF+ (ash 1 29)) ;; 十分大きな値 (ここでは 2^29 とする)

(defun main ()
  (let ((S) (U))
    
    ;; 入力
    (setf S (string (read)))
    (setf U (string (read))) ;; T は特別なシンボルなので避ける

    ;; DP テーブル定義 (このループ操作の場合 INF への初期化は不要)
    (let ((dp (make-array (list (1+ (length S))
				(1+ (length U))))))

      ;; DPループ
      (loop for i to (length S)
	 do (loop for j to (length U)
	       do (setf (aref dp i j)
			(min

			 ;; 初期条件
			 (if (and (= i 0) (= j 0))
			     0
			     +INF+)
      
			 ;; 変更操作
			 (if (and (> i 0) (> j 0))
			     (if (equal (char S (1- i))
					(char U (1- j)))
				 (aref dp (1- i) (1- j))
				 (1+ (aref dp (1- i) (1- j))))
			     +INF+)

			 ;; 削除操作
			 (if (> i 0)
			     (1+ (aref dp (1- i) j))
			     +INF+)

			 ;; 挿入操作
			 (if (> j 0)
			     (1+ (aref dp i (1- j)))
			     +INF+)))))

      ;; 最適値の出力
      (princ (aref dp (length S) (length U)))
      (terpri))))

(main)
