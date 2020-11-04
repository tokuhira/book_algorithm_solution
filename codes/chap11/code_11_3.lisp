;; Union-Find
(defstruct (union-find
	    ;; 初期化
	    (:constructor create-union-find
		(n &aux
		     (par (make-array n :initial-element -1))
		     (siz (make-array n :initial-element 1)))))
  par siz)

;; 根を求める
(defun union-find-root (u x)
  (if (= (aref (union-find-par u) x) -1)
      x ;; x が根の場合は x を返す
      (setf (aref (union-find-par u) x)
	    (union-find-root u (aref (union-find-par u) x)))))

;; x と y が同じグループに属するかどうか (根が一致するかどうか)
(defun union-find-issame (u x y)
  (= (union-find-root u x)
     (union-find-root u y)))

;; x を含むグループと y を含むグループとを併合する
(defun union-find-unite (u x y)
  ;; x, y をそれぞれ根まで移動する
  (setf x (union-find-root u x))
  (setf y (union-find-root u y))

  ;; すでに同じグループのときは何もしない
  (if (= x y) (return-from union-find-unite nil))

  ;; union by size (y 側のサイズが小さくなるようにする)
  (if (< (aref (union-find-siz u) x)
	 (aref (union-find-siz u) y))
      (let ((tmp x)) (setf x y) (setf y tmp)))

  ;; y を x の子とする
  (setf (aref (union-find-par u) y) x)
  (incf (aref (union-find-siz u) x)
	(aref (union-find-siz u) y))
  t)

;; x を含むグループのサイズ
(defun union-find-size (u x)
  (aref (union-find-siz u) x))

(defun main ()
  (let ((uf (create-union-find 7)))

    (union-find-unite uf 1 2) ;; {0}, {1, 2}, {3}, {4}, {5}, {6}
    (union-find-unite uf 2 3) ;; {0}, {1, 2, 3}, {4}, {5}, {6}
    (union-find-unite uf 5 6) ;; {0}, {1, 2, 3}, {4}, {5, 6}

    (format t "~S~%" (union-find-issame uf 1 3)) ;; True
    (format t "~S~%" (union-find-issame uf 2 5)) ;; False

    (union-find-unite uf 1 6) ;; {0}, {1, 2, 3, 5, 6}, {4}
    (format t "~S~%" (union-find-issame uf 2 5)))) ;; True

(main)
