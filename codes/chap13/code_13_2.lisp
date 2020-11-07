;; 深さ優先探索
(defparameter *seen* nil)
(defun dfs (G v)
  (setf (aref *seen* v) t) ;; v を訪問済にする

  ;; 訪問した頂点を確認
  ;(format *error-output* "v: ~S~%" v)
  
  ;; v から行ける各頂点 next_v について
  (loop for next_v across (aref G v)
     unless (aref *seen* next_v) ;; next_v が探索済ならば探索しない
     do (dfs G next_v))) ;; 再帰的に探索

(defun main ()
  (let ((N) (M) (G))
    ;; 頂点数と辺数
    (setf N (read))
    (setf M (read))
    
    ;; グラフ入力受取 (ここでは有向グラフを想定)
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read))
		(b (read)))
	    (vector-push-extend b (aref G a))))

    ;; 読み込んだグラフを確認
    ;(format *error-output* "G: ~S~%" G)

    ;; 探索
    (setf *seen* (make-array N :initial-element nil)) ;; 初期状態では全頂点が未訪問
    (loop for v below N
       unless (aref *seen* v) ;; すでに訪問済みなら探索しない
       do (dfs G v))
    
    ;; 訪問済みフラグを確認
    ;(format *error-output* "seen: ~S~%" *seen*)

    ))

(main)
