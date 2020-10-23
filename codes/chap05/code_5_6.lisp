(defparameter *INF* (ash 1 60)) ;; 十分大きい値とする (ここでは 2^60)
(defparameter *N* nil)
(defparameter *h* nil)
(defparameter *dp* nil)

(defun rec (i)
  ;; DP の値が更新されていたらそのままリターン
  (cond ((< (aref *dp* i) *INF*) (aref *dp* i))

	;; ベースケース: 足場 0 のコストは 0
	((= i 0) 0)

	;; 結果をメモしながら、返す
	(t (setf (aref *dp* i)
		 (min

		  ;; 足場 i - 1 と i - 2 のどちらから来た場合でも調べる値
		  (+ (rec (- i 1))
		     (abs (- (aref *h* i) (aref *h* (- i 1)))))
	      
		  ;; 足場 i - 2 から来た場合に調べる値 (そうでなければ INF)
		  (if (> i 1)
		      (+ (rec (- i 2))
			 (abs (- (aref *h* i) (aref *h* (- i 2)))))
		      *INF*))))))

(defun main ()
  ;; 入力受け取り
  (setf *N* (read))
  (setf *h* (make-array *N*))
  (loop for i below *N*
	do (setf (aref *h* i) (read)))

  ;; 初期化 (最小化問題なので INF に初期化)
  (setf *dp* (make-array *N* :initial-element *INF*))

  ;; 答え
  (princ (rec (- *N* 1)))
  (terpri))

(main)
