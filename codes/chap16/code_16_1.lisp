;; 辺を表す構造体
(defstruct edge
  (rev) ;; rev: 逆辺 (to, from) が G[to] の中で何番目の要素か
  (from)
  (to)
  (c)) ;; cap: 辺 (from, to) の容量

;; グラフを表す構造体
(defstruct (graph
	     (:constructor create-graph
			   (n &aux ;; N: 頂点数
			      (lst (map 'vector
					(lambda (x)
					  (setf x (make-array 0
							      :element-type 'edge
							      :adjustable t
							      :fill-pointer t)))
					(make-array n))))))
  lst) ;; 隣接リスト

;; グラフの頂点数取得
(defun size-graph (g)
  (length (graph-lst g)))

;; 辺 e = (u, v) の逆辺 (v, u) を取得する
(defun redge-graph (g e)
  (aref (aref (graph-lst g)
	      (edge-to e))
	(edge-rev e)))

;; 辺 e = (u, v) に流量 f のフローを流す
;; e = (u, v) の流量が f だけ減少する
;; このとき逆辺 (v, u) の流量を増やす
(defun run-flow-edge-graph (g e f)
  (decf (edge-c e) f)
  (incf (edge-c (redge-graph g e)) f))

;; 頂点 from から頂点 to へ容量 cap の辺を張る
;; このとき to から from へも容量 0 の辺を張っておく
(defun addedge-graph (g from to cap)
  (let ((lst (graph-lst g)))
    (let ((fromrev (length (aref lst from)))
	  (torev (length (aref lst to))))
      (vector-push-extend (make-edge :rev torev :from from :to to :c cap) (aref lst from))
      (vector-push-extend (make-edge :rev fromrev :from to :to from :c 0) (aref lst to)))))

;; フォード・ファルカーソン法
(defstruct ford-fulkerson
  (inf (ash 1 30)) ;; 無限大を表す値を適切に
  (seen))

;; 残余グラフ上で s-u パスを見つける (深さ優先探索)
;; 返り値は s-u パス上の容量の最小値 (見つからなかったら 0)
;; f: s から v へ到達した過程の各辺の容量の最小値
(defun fodfs (ff g v u f)
  ;; 終端 u に到達したらリターン
  (if (= v u) (return-from fodfs f))
  
  ;; 深さ優先探索
  (setf (aref (ford-fulkerson-seen ff) v) t)
  (loop for e across (aref (graph-lst g) v)
     unless (or (aref (ford-fulkerson-seen ff) (edge-to e))
		(= (edge-c e) 0)) ;; 容量 0 の辺は実際には存在しない

     ;; s-u パスを探す
     ;; 見つかったら flow はパス上の最小容量
     ;; 見つからなかったら f = 0
     do (let ((flow (fodfs ff g (edge-to e) u (min f (edge-c e)))))

	  ;; s-t パスが見つからなかったら次辺を試す
	  (unless (= flow 0)

	    ;; 辺 e に容量 flow のフローを流す
	    (run-flow-edge-graph g e flow)

	    ;; s-t パスを見つけたらパス上最小容量を返す
	    (return-from fodfs flow))))

  ;; s-t パスが見つからなかったことを示す
  0)

;; グラフ G の s-u 間の最大流量を求める
;; ただしリターン時に G は残余グラフになる
(defun solve (ff g s u)
  (let ((res 0))

    ;; 残余グラフに s-u パスがなくなるまで反復
    (loop with flow
       do (setf (ford-fulkerson-seen ff) (make-array (size-graph g) :initial-element nil))
	  (setf flow (fodfs ff G s u (ford-fulkerson-inf ff)))

       ;; s-t パスが見つからなかったら終了
       if (= flow 0)
       do (return-from solve res)

       ;; 答えを加算
       else
       do (incf res flow)))

  ;; no reach
  0)

(defun main ()
  ;; グラフの入力
  ;; N: 頂点数、M: 辺数
  (let ((N (read))
	(M (read))
	(G))
    (setf G (create-graph N))
    (loop for i below M
       do (let ((u (read))
		(v (read))
		(c (read)))
	    ;; 容量 c の辺 (u, v) を張る
	    (addedge-graph G u v c)))

    ;; フォード・ファルカーソン法
    (let ((ff (make-ford-fulkerson))
	  (s 0)
	  (u (1- N)))
      (princ (solve ff G s u))
      (terpri))))

(main)
