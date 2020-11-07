;; code_9_2.lisp の実装を構造体化
(defconstant +MAX+ 100000) ;; キュー配列の最大サイズ
(defstruct queue
  (qu (make-array +MAX+)) ;; キューを表す配列
  (tail 0) ;; キューの要素の挿入位置を表す変数
  (head 0)) ;; キューの要素の先頭位置を表す変数
(defun clear-queue (q) ;; キューを初期化する
  (setf (queue-tail q) 0)
  (setf (queue-head q) 0))
(defun emptyp-queue (q);; キューが空かどうかを判定する
  (= (queue-head q) (queue-tail q)))
(defun fullp-queue (q) ;; キューが満杯かどうかを判定する
  (= (queue-head q) (mod (1+ (queue-tail q)) +MAX+)))
(defun enqueue-queue (q x) ;; enqueue
  (cond ((fullp-queue q)
         (format *error-output* "error: queue is full.~%"))
	(t
	 (setf (aref (queue-qu q) (queue-tail q)) x)
	 (incf (queue-tail q))
	 (if (= (queue-tail q) +MAX+)
	     (setf (queue-tail q) 0))))) ;; リングバッファの終端に来たら 0 に
(defun dequeue-queue (q) ;; dequeue
  (cond ((emptyp-queue q)
         (format *error-output* "error: queue is empty.~%")
         -1)
	(t
	 (let ((res (aref (queue-qu q) (queue-head q))))
	   (incf (queue-head q))
	   (if (= (queue-head q) +MAX+)
	       (setf (queue-head q) 0)) ;; リングバッファの終端に来たら 0 に
	   res))))

;; 入力: グラフ G と，探索の始点 s
;; 出力: s から各頂点への最短路長を表す配列
(defun bfs (G s)
  (let ((N) (dist) (que))
    (setf N (length G)) ;; 頂点数
    (setf dist (make-array N :initial-element -1)) ;; 全頂点を「未訪問」に初期化
    (setf que (make-queue))

    ;; 初期条件 (頂点 s を初期頂点とする)
    (setf (aref dist 0) s)
    (enqueue-queue que s) ;; s を橙色頂点にする

    ;; BFS 開始 (キューが空になるまで探索を行う)
    (loop until (emptyp-queue que)
       do (let ((v (dequeue-queue que))) ;; キューから先頭頂点を取り出す
	    
	    ;; v からたどれる頂点をすべて調べる
	    (loop for x across (aref G v)
	       ;; すでに発見済みの頂点は探索しない
	       unless (/= (aref dist x) -1)

	       ;; 新たな白色頂点 x について距離情報を更新してキューに挿入
	       do (setf (aref dist x)
			(1+ (aref dist v)))
	       and
	       do (enqueue-queue que x))))

    dist))

(defun main ()
  (let ((N) (M) (G))
    ;; 頂点数と辺数
    (setf N (read))
    (setf M (read))
    
    ;; グラフ入力受取 (ここでは無向グラフを想定)
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read))
		(b (read)))
	    (vector-push-extend b (aref G a))
	    (vector-push-extend a (aref G b))))


    ;; 読み込んだグラフを表示
    (format *error-output* "G: ~S~%" G)

    ;; 頂点 0 を始点とした BFS
    (let ((dist (bfs G 0)))

      ;; 結果出力 (各頂点の頂点 0 からの距離を見る)
      (loop for v below N
	 do (format t "~S: ~S~%" v (aref dist v))))))

(main)
