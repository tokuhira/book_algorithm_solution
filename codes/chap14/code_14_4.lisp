;; 無限大を表す値 (ここでは 2^60 とする)
(defconstant +INF+ (ash 1 60))

;; 辺を表す型，ここでは重みを表す型を long long 型とします
(defstruct edge
  (to) ;; 隣接頂点番号
  (w)) ;; 重み

;; 緩和を実施する関数 (toDO: 非常にナイーブな実装につき改善すること)
(defmacro chmin (a b)
  `(if (> ,a ,b)
       (progn (setf ,a ,b)
	      t)
       nil))

;; car が小さな cons セルを取り出すヒープの実装 (TODO: 場当たり的な実装を改善)
(defconstant +initial-heap-size+ 0)
(defstruct heap
  (heap (make-array +initial-heap-size+ :fill-pointer 0 :adjustable t)))
(defun push-heap (h x) ;; x は cons セル
  (let ((the-heap (heap-heap h)))
    (vector-push-extend x the-heap) ;; 最後尾に挿入
    (let ((i (1- (length the-heap)))) ;; 挿入された頂点番号
      (loop
	 (unless (> i 0) (return))
	 (let ((p (floor (1- i) 2))) ;; 親の頂点番号
	   (if (<= (car (aref the-heap p)) (car x)) (return)) ;; 逆転がなければ終了
	   (setf (aref the-heap i) (aref the-heap p)) ;; 自分の値を親の値にする
	   (setf i p))) ;; 自分は上に行く
      (setf (aref the-heap i) x)))) ;; x は最終的にはこの位置にもってくる
(defun top-heap (h)
  (let ((the-heap (heap-heap h)))
    (if (> (length the-heap) 0)
	(aref the-heap 0)
	-1)))
(defun pop-heap (h)
  (let ((the-heap (heap-heap h)))
    (unless (> (length the-heap) 0) (return-from pop-heap))
    (let ((x (vector-pop the-heap)) ;; 頂点にもってくる値
	  (i 0)) ;; 根から降ろしていく
      (loop
	 (unless (< (1+ (* i 2)) (length the-heap)) (return))
         ;; 子頂点同士を比較して小さい方を child1 とする
	 (let ((child1 (1+ (* i 2)))
	       (child2 (+ (* i 2) 2)))
	   (if (and (< child2 (length the-heap))
		    (< (car (aref the-heap child2)) (car (aref the-heap child1))))
	       (setf child1 child2))
           (if (>= (car (aref the-heap child1)) (car x)) (return)) ;; 逆転がなければ終了
           (setf (aref the-heap i) (aref the-heap child1)) ;; 自分の値を子頂点の値にする
           (setf i child1))) ;; 自分は下に行く
      (setf (aref the-heap i) x)))) ;; x は最終的にはこの位置にもってくる
(defun emptyp-heap (h)
  (= (length (heap-heap h)) 0))

(defun main ()
  ;; 頂点数，辺数，始点
  (let ((N (read))
	(M (read))
	(s (read))
	(G))
    
    ;; グラフ
    (setf G (make-array N))
    (loop for i below N
       do (setf (aref G i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below M
       do (let ((a (read))
		(b (read))
		(w (read)))
	    (vector-push-extend (make-edge :to b :w w) (aref G a))))

    ;; ダイクストラ法
    (let ((dist (make-array N :initial-element +INF+))
	  (que (make-heap)))
      (setf (aref dist s) 0)

      ;; (d[v], v) のペアを要素としたヒープを作る
      (push-heap que (cons (aref dist s) s))

      ;; ダイクストラ法の反復を開始
      (loop until (emptyp-heap que)
	 with v ;; v: 使用済みでない頂点のうち d[v] が最小の頂点
	 with d ;; d: v に対するキー値
	 do (let ((top (top-heap que)))
	      (setf v (cdr top))
	      (setf d (car top)))
	    (pop-heap que)
	      
	 ;; d > dist[v] は，(d, v) がゴミであることを意味する
	 unless (> d (aref dist v))

	 ;; 頂点 v を始点とした各辺を緩和
	 do (loop for e across (aref G v)
	       if (chmin (aref dist (edge-to e))
			 (+ (aref dist v) (edge-w e)))
	       do (push-heap que (cons (aref dist (edge-to e)) (edge-to e)))))

      ;; 結果出力
      (loop for v below N
	 if (< (aref dist v) +INF+)
	 do (format t "~S~%" (aref dist v))
	 else
	 do (format t "INF~%")))))

(main)
