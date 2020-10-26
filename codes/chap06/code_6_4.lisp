(defconstant +INF+ 20000000) ;; 十分大きな値に

(defun lower-bound (v key) ;; code_6_1.lisp の binary-search とほぼ同じ処理
  (let ((left 0) ;; 配列 v の左端
	(right (1- (length v))) ;; 配列 v の右端
	(mid))
    (loop
       (if (< right left) (return left)) ;; binary-search での -1 と異なり、left を返す
       (setf mid (+ left (floor (/ (- right left) 2)))) ;; 区間の真ん中
       (if (= (aref v mid) key) (return mid))
       (if (> (aref v mid) key) (setf right (1- mid)))
       (if (< (aref v mid) key) (setf left (1+ mid))))))

(defun search-minimum-pair-sum-of-k-or-above (N K a b)
  ;; b をソート
  (sort b #'<)

  ;; b に無限大を表す値 (INF) を追加しておく
  ;; これを行うことで、iter = b.end() となる可能性を除外する
  (vector-push-extend +INF+ b)

  ;; a を固定して解く
  (loop for i below N
     minimize (+ (aref a i)
		 (aref b (lower-bound b (- K (aref a i)))))))

(defun main ()
  (let ((N) (K) (a) (b))

    ;; 入力を受け取る
    (setf N (read))
    (setf K (read))
    (setf a (make-array N))
    (setf b (make-array N :adjustable t :fill-pointer t))
    (loop for i below N
       do (setf (aref a i) (read)))
    (loop for i below N
       do (setf (aref b i) (read)))

    #|
    ;; サンプル手盛り
    (setf N 3)
    (setf K 8)
    (setf a (make-array N :initial-contents '(2 6 4)))
    (setf b (make-array N :initial-contents '(5 7 3) :adjustable t :fill-pointer t))
    |#

    ;; 核心部の呼び出しと結果の出力
    (princ (search-minimum-pair-sum-of-k-or-above N K a b))
    (terpri)))

(main)
