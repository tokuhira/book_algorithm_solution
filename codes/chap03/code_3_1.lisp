(defun main ()
  ;; 入力を受け取る
  (let ((N) (v)	(a))
    (setf N (read))
    (setf v (read))
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; 線形探索
    (let ((exist nil))
      (loop for i below N
	 if (= (aref a i) v)
	 do (setf exist t))

      ;; 結果出力
      (if exist
	  (princ "Yes")
	  (princ "No"))
      (terpri))))

(main)
