;; 入力
(defparameter *w* nil) ;; 各頂点の重み
(defparameter *G* nil) ;; グラフ

;; 木上の動的計画法テーブル
(defparameter *dp1* nil)
(defparameter *dp2* nil)

(defun dfs (v &optional (p -1))
  ;; 最初に各子頂点を探索しておきます
  (loop for ch across (aref *G* v)
     unless (= ch p)
     do (dfs ch v))

  ;; 帰りがけ時に動的計画法
  (setf (aref *dp1* v) 0)            ;; 初期条件
  (setf (aref *dp2* v) (aref *w* v)) ;; 初期条件
  (loop for ch across (aref *G* v)
     unless (= ch p)
     do (incf (aref *dp1* v) (max (aref *dp1* ch)
				  (aref *dp2* ch)))
	(incf (aref *dp2* v) (aref *dp1* ch))))

(defun main ()
  ;; 頂点数 (木なので辺数は N - 1 で確定)
  (let ((N (read))) 

    ;; 重みとグラフの入力受取
    (setf *w* (make-array N))
    (loop for i below N
       do (setf (aref *w* i) (read)))
    (setf *G* (make-array N))
    (loop for i below N
       do (setf (aref *G* i) (make-array 0 :adjustable t :fill-pointer t)))
    (loop for i below (1- N)
       do (let ((a (read))
		(b (read)))
	    (vector-push-extend b (aref *G* a))
	    (vector-push-extend a (aref *G* b))))

    ;; 探索
    (let ((root 0)) ;; 仮に頂点 0 を根とする
      (setf *dp1* (make-array N :initial-element 0))
      (setf *dp2* (make-array N :initial-element 0))
      (dfs root)

      ;; 結果
      (format t "~S~%" (max (aref *dp1* root)
			    (aref *dp2* root))))))

(main)
