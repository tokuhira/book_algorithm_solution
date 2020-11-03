(defconstant +initial-heap-size+ 0)
(defstruct heap
  (heap (make-array +initial-heap-size+ :fill-pointer 0 :adjustable t)))

;; ヒープに値 x を挿入
(defun heap-push (h x)
  (let ((the-heap (heap-heap h)))
    (vector-push-extend x the-heap) ;; 最後尾に挿入
    (let ((i (1- (length the-heap)))) ;; 挿入された頂点番号
      (loop
	 (unless (> i 0) (return))
	 (let ((p (floor (1- i) 2))) ;; 親の頂点番号
	   (if (>= (aref the-heap p) x) (return)) ;; 逆転がなければ終了
	   (setf (aref the-heap i) (aref the-heap p)) ;; 自分の値を親の値にする
	   (setf i p))) ;; 自分は上に行く
      (setf (aref the-heap i) x)))) ;; x は最終的にはこの位置にもってくる

;; 最大値を知る
(defun heap-top (h)
  (let ((the-heap (heap-heap h)))
    (if (> (length the-heap) 0)
	(aref the-heap 0)
	-1)))

;; 最大値を削除
(defun heap-pop (h)
  (let ((the-heap (heap-heap h)))
    (unless (> (length the-heap) 0) (return-from heap-pop))
    (let ((x (vector-pop the-heap)) ;; 頂点にもってくる値
	  (i 0)) ;; 根から降ろしていく
      (loop
	 (unless (< (1+ (* i 2)) (length the-heap)) (return))
         ;; 子頂点同士を比較して大きい方を child1 とする
	 (let ((child1 (1+ (* i 2)))
	       (child2 (+ (* i 2) 2)))
	   (if (and (< child2 (length the-heap))
		    (> (aref the-heap child2) (aref the-heap child1)))
	       (setf child1 child2))
           (if (<= (aref the-heap child1) x) (return)) ;; 逆転がなければ終了
           (setf (aref the-heap i) (aref the-heap child1)) ;; 自分の値を子頂点の値にする
           (setf i child1))) ;; 自分は下に行く
      (setf (aref the-heap i) x)))) ;; x は最終的にはこの位置にもってくる

(defun main ()
  (let ((h (make-heap)))
    (mapc (lambda (x)
	    (heap-push h x))
	  '(5 3 7 1))

    (format t "~S~%" (heap-top h)) ;; 7
    (heap-pop h)
    (format t "~S~%" (heap-top h)) ;; 5

    (heap-push h 11)
    (format t "~S~%" (heap-top h)))) ;; 11

(main)
