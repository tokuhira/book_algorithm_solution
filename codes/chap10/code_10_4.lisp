(defstruct edge
  (to) ;; 隣接頂点番号
  (w)) ;; 重み

(defun main ()
  (let ((N) (M) (G))
    ;; 頂点数と辺数
    (setf N (read))
    (setf M (read))
    
    ;; グラフ
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read))
		(b (read))
		(w (read)))
	    (vector-push-extend (make-edge :to b :w w) (aref G a))))

    ;; デバッグ出力
    ;(princ G *error-output*)
    ;(terpri *error-output*)
    ))

(main)
