;; Union-Find
(defstruct (union-find
	    (:constructor create-union-find
		(n &aux
		     (par (make-array n :initial-element -1))
		     (siz (make-array n :initial-element 1)))))
  par siz)

;; 根を求める
(defun union-find-root (u x)
  (if (= (aref (union-find-par u) x) -1)
      x
      (setf (aref (union-find-par u) x)
	    (union-find-root u (aref (union-find-par u) x)))))

;; x と y が同じグループに属するかどうか (根が一致するかどうか)
(defun union-find-issame (u x y)
  (= (union-find-root u x)
     (union-find-root u y)))

;; x を含むグループと y を含むグループとを併合する
(defun union-find-unite (u x y)
  (setf x (union-find-root u x))
  (setf y (union-find-root u y))
  (if (= x y) (return-from union-find-unite nil))
  (if (< (aref (union-find-siz u) x)
	 (aref (union-find-siz u) y))
      (let ((tmp x)) (setf x y) (setf y tmp)))
  (setf (aref (union-find-par u) y) x)
  (incf (aref (union-find-siz u) x)
	(aref (union-find-siz u) y))
  t)

;; x を含むグループのサイズ
(defun union-find-size (u x)
  (aref (union-find-siz u) x))

(defun main ()
  (let ((N) (M) (uf))
    ;; 頂点数と辺数
    (setf N (read))
    (setf M (read))
    
    ;; Union-Find を要素数 N で初期化
    (setf uf (create-union-find N))

    ;; 各辺に対する処理
    (loop for i below M
       do (let ((a (read))
		(b (read)))
	    (union-find-unite uf a b))) ;; a を含むグループと b を含むグループを併合する

    ;; 集計
    (princ (loop for x below N
	      sum (if (= (union-find-root uf x) x) 1 0)))
    (terpri)))

(main)
