;; 配列 a の区間 [left, right) をソートする
;; [left, right) は，left, left+1, ..., right-1 番目を表す
(defun merge-sort (a left right)
  (if (= (- right left) 1) (return-from merge-sort))
  ;(format *error-output* "[~S,~S)  -> ~S~%" left right a)
  (let ((mid (+ left (floor (- right left) 2))))

    ;; 左半分 [left, mid) をソート
    (merge-sort a left mid)

    ;; 右半分 [mid, right) をソート
    (merge-sort a mid right)

    ;; いったん「左」と「右」のソート結果をコピーしておく (右側は左右反転)
    (let ((buf (concatenate 'vector
			    (subseq a left mid)
			    (nreverse (subseq a mid right)))))
      
      ;; 併合する
      (let ((index-left 0) ;; 左側の添字
	    (index-right (1- (length buf)))) ;; 右側の添字
	(loop for i from left below right
	   ;; 左側採用
	   if (<= (aref buf index-left) (aref buf index-right))
	   do (setf (aref a i) (aref buf index-left))
	      (incf index-left)

	   ;; 右側採用
	   else
	   do (setf (aref a i) (aref buf index-right))
	      (decf index-right)))))

  ;(format *error-output* "[~S,~S) <-  ~S~%" left right a)
  )

(defun main ()
  ;; 入力
  (let ((N) (a))
    (setf N (read)) ;; 要素数
    (setf a (make-array N))
    (loop for i below N
       do (setf (aref a i) (read)))

    ;; マージソート
    (merge-sort a 0 N)))

(main)
