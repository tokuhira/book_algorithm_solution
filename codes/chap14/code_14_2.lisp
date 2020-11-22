;; 無限大を表す値
(defconstant +INF+ (ash 1 60)) ;; 十分大きな値を用いる (ここでは 2^60)

;; 辺を表す型，ここでは重みを表す型を long long 型とする
(defstruct edge
  (to) ;; 隣接頂点番号
  (w)) ;; 重み

;; 緩和を実施する関数 (TODO: chmin はマクロを学んで実装)

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

    ;; ベルマン・フォード法
    (let ((exist_negative_cycle nil) ;; 負閉路をもつかどうか
	  (dist (make-array N :initial-element +INF+)))
      (setf (aref dist s) 0)
      (loop for iter below N
	 with update ;; 更新が発生したかどうかを表すフラグ
	 do (setf update nil)
	    (loop for v below N
	       ;; dist[v] = INF のときは頂点 v からの緩和を行わない
	       unless (= (aref dist v) +INF+)

	       do (loop for e across (aref G v)
		     ;; 緩和処理を行い，更新されたら update を true にする
		     if (> (aref dist (edge-to e))
			   (+ (aref dist v) (edge-w e)))
		     do
		       (setf (aref dist (edge-to e))
			     (+ (aref dist v) (edge-w e)))
		       (setf update t)))

	 ;; 更新が行われなかったら，すでに最短路が求められている
	 when (not update) return 'finish

	 ;; N 回目の反復で更新が行われたならば，負閉路をもつ
	 if (and (= iter (1- N)) update)
	 do (setf exist_negative_cycle t))

      ;; 結果出力
      (if exist_negative_cycle
	  (format t "NEGATIVE CYCLE~%")
	  (loop for v below N
	     if (< (aref dist v) +INF+)
	     do (format t "~S~%" (aref dist v))
	     else
	     do (format t "INF~%"))))))

(main)
