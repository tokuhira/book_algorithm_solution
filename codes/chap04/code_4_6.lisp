(defun fibo (N)
  (format t "fibo(~S) を呼び出しました~%" N)

  ;; ベースケース
  (cond ((= N 0) 0)
	((= N 1) 1)

	;; 再帰的に答えを求めて出力する
	(t (let ((result (+ (fibo (- N 1))
			    (fibo (- N 2)))))
	     (format t "~S 項目 = ~S~%" N result)

	     result))))

(fibo 6)
