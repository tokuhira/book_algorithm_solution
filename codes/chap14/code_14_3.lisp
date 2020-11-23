;; 無限大を表す値
(defconstant +INF+ (ash 1 60)) ;; 十分大きな値を用いる (ここでは 2^60)

;; 辺を表す型，ここでは重みを表す型を long long 型とする
(defstruct edge
  (to) ;; 隣接頂点番号
  (w)) ;; 重み

;; 緩和を実施する関数 (TODO: 非常にナイーブな実装につき改善すること)
(defmacro chmin (a b)
  `(if (> ,a ,b)
       (progn (setf ,a ,b)
	      t)
       nil))

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
    (let ((used (make-array N :initial-element nil))
	  (dist (make-array N :initial-element +INF+))
	  (min_dist)
	  (min_v))
      (setf (aref dist s) 0)
      (loop for iter below N
	 ;; 「使用済み」でない頂点のうち，dist 値が最小の頂点を探す
	 do (setf min_dist +INF+)
	    (setf min_v -1)
	    (loop for v below N
	       if (and (not (aref used v))
		       (< (aref dist v) min_dist))
	       do (setf min_dist (aref dist v))
		  (setf min_v v))

	 ;; もしそのような頂点が見つからなければ終了する
	 if (= min_v -1) return 'not-found

	 ;; min_v を始点とした各辺を緩和する
	 do (loop for e across (aref G min_v)
	       do (chmin (aref dist (edge-to e))
			 (+ (aref dist min_v) (edge-w e))))

	    (setf (aref used min_v) t)) ;; min_v を「使用済み」とする

      ;; 結果出力
      (loop for v below N
	 if (< (aref dist v) +INF+)
	 do (format t "~S~%" (aref dist v))
	 else
	 do (format t "INF~%")))))

(main)
