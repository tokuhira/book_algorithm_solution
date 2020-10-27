(defparameter *value* #(500 100 50 10 5 1))

(defun find-fewest-coins (X a)
  (loop
     for i below (length a)
     sum
       ;; 枚数制限がない場合の枚数
       (let ((add) (floor X (aref *value* i)))

	 ;; 枚数制限を考慮
	 (if (> add (aref a i))
	     (setf add (aref a i)))

	 ;; 残り金額を求めて，答えに枚数を加算する
	 (setf X (- X (* (aref *value* i) add)))
	 add)))

(defun main ()
  (let ((X) (a))

    ;; 入力
    (setf X (read))
    (setf a (make-array (length *value*)))
    (loop
       for i below (length a)
       do (setf (aref a i) (read)))

    ;; 貪欲法
    (princ (find-fewest-coins X a))
    (terpri)))

(main)
