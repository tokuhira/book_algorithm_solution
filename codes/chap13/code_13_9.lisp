;; 木上の探索
(defparameter *depth* nil)
(defparameter *subtree_size* nil)
(defun dfs (G v &optional (p -1) (d 0))
  (setf (aref *depth* v) d)
  (loop for c across (aref G v)
     unless (= c p) ;; 探索が親方向へ逆流するのを防ぐ
     do (dfs G c v (1+ d)))

  ;; 帰りがけ時に、部分木サイズを求める
  (setf (aref *subtree_size* v) 1) ;; 自分自身
  (loop for c across (aref G v)
     unless (= c p)

     ;; 子頂点を根とする部分きのサイズを加算する
     do (incf (aref *subtree_size* v) (aref *subtree_size* c))))

(defun main ()
  (let ((N) (G))
    ;; 頂点数 (木なので辺数は N - 1 で確定)
    (setf N (read))
    
    ;; グラフ入力受取
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below (1- N)
       do (let ((a (read))
		(b (read)))
	    (vector-push-extend b (aref G a))
	    (vector-push-extend a (aref G b))))

    ;; 探索
    (setf *depth* (make-array N))
    (setf *subtree_size* (make-array N))
    (let ((root 0)) ;; 仮に頂点 0 を根とする
      (dfs G root))

    ;; 結果
    (loop for v below N
       do (format t "~S: depth = ~S, subtree_size = ~S~%"
		  v
		  (aref *depth* v)
		  (aref *subtree_size* v)))))

(main)
