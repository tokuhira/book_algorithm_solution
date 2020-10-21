(defun main ()
  ;; 入力受け取り
  (let ((N) (W) (a))
    (setf N (read))
    (setf W (read))
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; bit は 2^N 通りの部分集合全体を動く
    (let ((exist nil))
      (loop for bit below (ash 1 N)
	 if (= (loop for i below N ;; 部分集合に含まれる要素の和
		  if (logbitp i bit) ;; bit の i 番目のビットの真偽
		  sum (aref a i))
	       W)
	 do (setf exist t))

      ;; 結果出力
      (if exist
	  (princ "Yes")
	  (princ "No"))
      (terpri))))

(main)
