(defun func (i w a)
  ;; ベースケース
  (cond ((= i 0) (= w 0))

	;; a[i - 1] を選ばない場合
	((func (- i 1) w a) t)
	
	;; a[i - 1] をぶ場合
	((func (- i 1) (- w (aref a (- i 1))) a) t)

	;; どちらも false の場合は false
	(t nil)))

(defun main ()
  (let (N W a)
    ;; 入力
    (setf N (read))
    (setf W (read))
    (setf a (make-array N))
    (loop for i below N
	  do (setf (aref a i) (read)))
    
    ;; 再帰的に解く
    (if (func N W a)
	(princ "Yes")
	(princ "No"))
    (terpri)))

(main)
