;; トポロジカルソートする
(defparameter *seen* nil)
(defparameter *order* nil) ;; トポロジカルソート順を表す
(defun rec (G v)
  (setf (aref *seen* v) t)
  (loop for next_v across (aref G v)
     unless (aref *seen* next_v) ;; すでに訪問済みなら探索しない
     do (rec G next_v))

  ;; v-out を記録する
  (setf *order* (cons v *order*)))

(defun main ()
  ;; 頂点数と枝数
  (let ((N (read)) (M (read)) (G))
    (setf G (make-array N)) ;; 超点数 N のグラフ
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read)) (b (read)))
	    (vector-push-extend b (aref G a))))

    ;; 探索
    (setf *seen* (make-array N :initial-element nil)) ;; 初期状態では全頂点が未訪問
    (setf *order* ()) ;; トポロジカルソート順
    (loop for v below N
       unless (aref *seen* v) ;; すでに訪問済みなら探索しない
       do (rec G v))

    ;; 積んだのと逆順で出力
    (dolist (v *order* (terpri))
      (format t "~S -> " v))))

(main)
