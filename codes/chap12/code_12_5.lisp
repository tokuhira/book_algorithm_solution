(defconstant +MAX+ 100000) ;; ここでは配列の値は 100000 未満とする

;; バケットソート
(defun bucket-sort (a)
  (let ((N (length a))
	(num (make-array +MAX+ :initial-element 0))
	(sum (make-array +MAX+ :initial-element 0)))

    ;; 各要素の個数をカウントする
    ;; num[v]: v の個数
    (loop for i below N
       do (incf (aref num (aref a i)))) ;; a[i] をカウントする
    
    ;; num の累積和をとる
    ;; sum[v]: v 以下の値の個数
    ;; 値 a[i] が全体の中で何番目に小さいかを求める
    (setf (aref sum 0) (aref num 0))
    (loop for v from 1 below +MAX+
       do (setf (aref sum v)
		(+ (aref sum (1- v))
		   (aref num v))))

    ;; sum をもとにソート処理
    ;; a2: a をソートしたもの
    (let ((a2 (make-array N)))
      (loop for i from (1- N) downto 0
	 do (decf (aref sum (aref a i)))
	    (setf (aref a2 (aref sum (aref a i)))
		  (aref a i)))

      a2))) ;; 破壊的代入をする代わりに結果を返す

(defun main ()
  ;; 入力
  (let ((N) (a))
    (setf N (read)) ;; 要素数
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; バケットソート
    (bucket-sort a)))

(main)
