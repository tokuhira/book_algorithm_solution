(defparameter *memo* nil)

(defun fibo (N)
  ;; ベースケース
  (cond ((= N 0) 0)
	((= N 1) 1)

	;; メモをチェック (すでに計算済みならば答えをリターンする)
	((not (= (aref *memo* N) -1)) (aref *memo* N))

	;; 答えをメモ化しながら，再帰呼び出し
	(t (setf (aref *memo* N) (+ (fibo (- N 1))
				    (fibo (- N 2)))))))


(defun main ()
  ;; メモ化用配列を -1 で初期化する
  (setf *memo* (make-array 50 :initial-element -1))

  ;; fibo(49) をよびだす
  (fibo 49)

  ;; memo[0], ..., memo[49] に答えが格納されている
  (loop for N from 2 below 50
	do (format t "~S 項目: ~S~%" N (aref *memo* N))))

(main)
