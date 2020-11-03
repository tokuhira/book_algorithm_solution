(defconstant +INF+ (ash 1 60)) ;; 十分大きい値を 1 つ決める

(defun find-minimum-shooting-penarty (N h s)
  ;; 二分探索
  (let ((left 0)
	(right +INF+)
	(mid))
    (loop
      (if (<= (- right left) 1) (return right))
      (setf mid (floor (+ left right) 2))

      ;; 判定
      (let ((ok t)
	    (l (make-array N :initial-element 0))) ;; 各風船を割るまでの制限時間
	(loop for i below N
	  ;; そもそも mid が初期高度よりも低かったらfalse
	  if (< mid (aref h i))
	    do (setf ok nil)
	  else
	    do (setf (aref l i) (/ (- mid (aref h i)) (aref s i))))

	;; 時間制限がさし迫っている順にソート
	(sort l #'<)
	(loop for i below N
	  if (< (aref l i) i)
	    do (setf ok nil)) ;; 時間切れ発生

	(if ok
	    (setf right mid)
	    (setf left mid))))))

(defun main ()
  (let ((N) (h) (s))

    ;; 入力
    (setf N (read))
    (setf h (make-array N))
    (setf s (make-array N))
    (loop for i below N
       do (setf (aref h i) (read))
       do (setf (aref s i) (read)))

    ;; 核心部の呼び出しと結果の出力
    (princ (find-minimum-shooting-penarty N h s))
    (terpri)))

(main)
