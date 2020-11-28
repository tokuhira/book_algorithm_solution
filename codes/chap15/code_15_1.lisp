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
      (rotatef x y))
  (setf (aref (union-find-par u) y) x)
  (incf (aref (union-find-siz u) x)
	(aref (union-find-siz u) y))
  t)

;; x を含むグループのサイズ
(defun union-find-size (u x)
  (aref (union-find-siz u) x))

;; 辺 e = (u, v) を (w(e) . (u . v)) で表す
(defun main ()
  ;; 入力
  (let ((N (read)) (M (read)) ;; 頂点数と辺数
	(edges))
    (setf edges (make-array M)) ;; 辺集合
    (loop for i below M
       do (let ((u (read))
		(v (read))
		(w (read))) ;; w は重み
	    (setf (aref edges i) (cons w (cons u v)))))

    ;; 各辺を，辺の重みが小さい順にソートする
    (sort edges #'(lambda (a b) (if (= (car a) (car b))
				    (< (cadr a) (cadr b))
				    (< (car a) (car b)))))

    ;; クラスカル法
    (let ((res 0)
	  (uf (create-union-find N)))
      (loop for i below M
	 with w with u with v
	 do (setf w (car (aref edges i)))
	    (setf u (cadr (aref edges i)))
	    (setf v (cddr (aref edges i)))

	 ;; 辺 (u, v) の追加によってサイクルが形成されるときは追加しない
	 unless (union-find-issame uf u v)

	 ;; 辺 (u, v) を追加する
	 do (incf res w)
	    (union-find-unite uf u v))

      (princ res)
      (terpri))))

(main)
