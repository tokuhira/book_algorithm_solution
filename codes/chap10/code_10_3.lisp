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
		(b (read)))
	    (vector-push-extend b (aref G a))

	    ;; 無向グラフの場合は以下を追加
	    ;(vector-push-extend a (aref G b))
	    ))

    ;; デバッグ出力
    ;(princ G *error-output*)
    ;(terpri *error-output*)
    ))

(main)
