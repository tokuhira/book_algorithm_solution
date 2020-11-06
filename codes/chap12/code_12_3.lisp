;; 配列 a の区間 [left, right) をソートする
;; [left, right) は，left, left+1, ..., right-1 番目を表す
(defun quick-sort (a left right)
  (if (<= (- right left) 1) (return-from quick-sort))

  (let ((pivot-index (floor (+ left right) 2)) ;; 適当にここでは中点とします
	(pivot))
    (setf pivot (aref a pivot-index))
    (rotatef (aref a pivot-index) (aref a (1- right))) ;; pivot と右端を swap

    (let ((i left)) ;; i は左詰めされた pivot 未満要素の右端を表す
      (loop for j from left below (1- right)
	 if (< (aref a j) pivot) ;; pivot 未満のものがあったら左に詰めていく
	 do (progn (rotatef (aref a i) (aref a j))
		   (incf i)))

      (rotatef (aref a i) (aref a (1- right))) ;; pivot を適切な場所に挿入

    ;; 再帰的に解く
    (quick-sort a left i) ;; 左半分 (pivot 未満)
    (quick-sort a (1+ i) right)))) ;; 右半分 (pivot 以上)

(defun main ()
  ;; 入力
  (let ((N) (a))
    (setf N (read)) ;; 要素数
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; クイックソート
    (quick-sort a 0 N)))

(main)
