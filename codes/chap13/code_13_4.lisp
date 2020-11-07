;; 深さ優先探索
(defparameter *seen* nil)
(defun dfs (G v)
  (setf (aref *seen* v) t) ;; v を訪問済にする

  ;; v から行ける各頂点 next_v について
  (loop for next_v across (aref G v)
     unless (aref *seen* next_v) ;; next_v が探索済だったらスルー
     do (dfs G next_v))) ;; 再帰的に探索

(defun main ()
  (let ((N) (M) (s) (u) (G))
    ;; 頂点数と辺数、s と u
    (setf N (read))
    (setf M (read))
    (setf s (read))
    (setf u (read))
    
    ;; グラフ入力受取
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read))
		(b (read)))
	    (vector-push-extend b (aref G a))))

    ;; 頂点 s をスタートとした探索
    (setf *seen* (make-array N :initial-element nil)) ;; 全頂点を「未訪問」に初期化
    (dfs G s)

    ;; u にたどり着けるかどうか
    (format t "~A~%" (if (aref *seen* u) "Yes" "No"))))

(main)
