;; 区間を first と second のペアで表す
(defstruct interval
  first second)

;; 区間を終端時刻で大小比較する関数
(defun cmp (a b)
  (< (interval-second a) (interval-second b)))

;; 貪欲に選ぶ
(defun interval-scheduling-problem (inter)
  (let ((res 0))
    (loop for i across inter
       with current-end-time = 0
       ;; 最後に選んだ区間と被るのは除く
       unless (< (interval-first i) current-end-time)
       do (progn (incf res)
		 (setf current-end-time (interval-second i))))
    res))

(defun main ()
  (let ((N) (inter))

    ;; 入力
    (setf N (read))
    (setf inter (make-array N))
    (loop for i below N
       do (setf (aref inter i)
		(make-interval :first (read)
			       :second (read))))

    ;; 終端時刻が早い順にソートする
    (sort inter #'cmp)

    ;; 区間スケジューリング問題の結果を出力
    (princ (interval-scheduling-problem inter))
    (terpri)))

(main)
