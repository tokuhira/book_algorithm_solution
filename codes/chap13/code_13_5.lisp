;; 二部グラフ判定
(defparameter *color* nil)
(defun dfs (G v &optional (cur 0))
  (setf (aref *color* v) cur)
  (loop for next_v across (aref G v)
     ;; 隣接頂点がすでに色確定していた場合
     do (if (/= (aref *color* next_v) -1)
	    ;; 同じ色が隣接した場合は二部グラフではない
	    (if (= (aref *color* next_v) cur)
		(return-from dfs nil)

		;; 色が確定した場合には探索しない
		)

	    ;; 隣接頂点の色を変えて、再帰的に探索
	    ;; false が返ってきたら false を返す
	    (if (not (dfs G next_v (- 1 cur)))
		(return-from dfs nil))))

  t)

(defun main ()
  (let ((N) (M) (G))
    ;; 頂点数と辺数
    (setf N (read))
    (setf M (read))
    
    ;; グラフ入力受取
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read))
		(b (read)))
	    (vector-push-extend b (aref G a))
	    (vector-push-extend a (aref G b))))

    ;; 探索
    (setf *color* (make-array N :initial-element -1))
    (let ((is-bipartile t))
      (loop for v below N
	 unless (/= (aref *color* v) -1) ;; v が探索済みの場合は探索しない
	 do (unless (dfs G v) (setf is-bipartile nil)))

      (format t "~A~%" (if is-bipartile "Yes" "No")))))

(main)
