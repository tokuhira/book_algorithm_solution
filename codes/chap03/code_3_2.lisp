(defun main ()
  ;; 入力を受け取る
  (let ((N) (v)	(a))
    (setf N (read))
    (setf v (read))
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; 線形探索
    (let ((found_id
	   (loop for i below N
	      when (= (aref a i) v)
	      return i)))

      ;; 結果出力
      (princ (if found_id found_id -1))
      (terpri))))

(main)
